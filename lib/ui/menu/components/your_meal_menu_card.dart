import 'package:appetizer/app_theme.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/multimessing/components/qr_widget.dart';
import 'package:appetizer/ui/user_feedback/new_feedback_view.dart';
import 'package:appetizer/utils/color_utils.dart';
import 'package:appetizer/utils/menu_ui_utils.dart';
import 'package:appetizer/viewmodels/menu/your_menu_card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class YourMealsMenuCard extends StatefulWidget {
  final Meal meal;
  final DailyItems dailyItems;

  YourMealsMenuCard(this.meal, this.dailyItems);

  @override
  _YourMealsMenuCardState createState() => _YourMealsMenuCardState();
}

class _YourMealsMenuCardState extends State<YourMealsMenuCard> {
  YourMenuCardViewModel _model;

  Widget _buildMenuCardHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              MenuUIUtils.buildtitleAndBhawanNameComponent(widget.meal),
              SizedBox(width: 8),
              _buildSkippedFlagComponent(),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            if (_model.isSwitchEnabled) ...[
              _buildQRButtonComponent(),
              widget.meal.items.isNotEmpty
                  ? _buildSwitchComponent()
                  : Container(),
            ],
            _buildFeedbackOrToggleComponent(),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildMenuCardHeader(),
                SizedBox(height: 16),
                MenuUIUtils.buildMealItemsComponent(widget.meal),
              ],
            ),
          ),
          MenuUIUtils.buildDailyItemsComponent(
            widget.meal,
            widget.dailyItems,
          ),
          MenuUIUtils.buildSpecialMealBanner(
            widget.meal.costType,
          ),
        ],
      ),
    );
  }

  Widget _buildQRCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => _model.secretCode = null,
                        ),
                        MenuUIUtils.buildtitleAndBhawanNameComponent(
                            widget.meal),
                      ],
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(widget.meal.startDateTime),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QRWidget(
            switchId: widget.meal.switchStatus.id,
          ),
          Container(
            width: double.maxFinite,
            color: AppTheme.lightGrey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Scan this QR code at the mess reception and get delicious meal',
                style: AppTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackOrToggleComponent() {
    if (widget.meal.isOutdated) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () => Get.toNamed(NewFeedbackView.id),
          child: Image.asset(
            'assets/icons/feedback_button.png',
            height: 25,
            width: 25,
          ),
        ),
      );
    } else if (_model.isLeaveEnabled && !isCheckedOut) {
      GestureDetector(
        onHorizontalDragStart: (_) => _model.onSwitchDragged(),
        child: Switch(
          activeColor: AppTheme.primary,
          value: _model.mealLeaveStatus,
          onChanged: (_model.isLeaveToggleOutdated || !_model.mealSwitchStatus)
              ? null
              : _model.onLeaveChanged,
        ),
      );
    }
    return Container();
  }

  Widget _buildSwitchComponent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: widget.meal.isSwitchable
          ? GestureDetector(
              onTap: _model.onSwitchChanged,
              child: Image.asset(
                widget.meal.isLeaveToggleOutdated
                    ? 'assets/icons/switch_inactive.png'
                    : _model.mealSwitchStatus
                        ? 'assets/icons/switch_active.png'
                        : 'assets/icons/switch_crossed_active.png',
                width: 30,
              ),
            )
          : Container(),
    );
  }

  Widget _buildSkippedFlagComponent() {
    if (ColorUtils.getLeaveColorFromLeaveStatus(
                widget.meal.leaveStatus?.status) !=
            Colors.white &&
        widget.meal.isOutdated) {
      return Container(
        decoration: BoxDecoration(
          color: ColorUtils.getLeaveColorFromLeaveStatus(
              widget.meal.leaveStatus?.status),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'S',
            style: AppTheme.headline4.copyWith(color: AppTheme.white),
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildQRButtonComponent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: _model.onQRTapped,
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.getSwitchColorFromSwitchStatus(
              widget.meal.switchStatus,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: widget.meal.switchStatus.status == SwitchStatusEnum.N
              ? Container()
              : Image.asset(
                  'assets/icons/qr_image.png',
                  height: 40,
                  width: 40,
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<YourMenuCardViewModel>(
        onModelReady: (model) {
          _model = model;
          _model.meal = widget.meal;
          _model.dailyItems = widget.dailyItems;
          _model.isLeaveToggleOutdated = widget.meal?.isLeaveToggleOutdated ??
              _model.isLeaveToggleOutdated;
          _model.updateMealLeaveAndSwitchStatus(widget.meal);
        },
        onDidUpdateWidget: (oldWidget, model) =>
            _model.updateMealLeaveAndSwitchStatus(widget.meal),
        builder: (context, model, child) {
          if (widget.meal == null) return Container();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _model.isSwitchEnabled && _model.secretCode != null
                ? _buildQRCard()
                : _buildMenuCard(),
          );
        });
  }
}
