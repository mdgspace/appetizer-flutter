import 'package:appetizer/app_theme.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/multimessing/components/qr_widget.dart';
import 'package:appetizer/ui/user_feedback/new_feedback_view.dart';
import 'package:appetizer/utils/color_utils.dart';
import 'package:appetizer/utils/menu_ui_utils.dart';
import 'package:appetizer/viewmodels/menu/your_menu_card_viewmodel.dart';
import 'package:appetizer/viewmodels/menu/your_menu_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YourMealsMenuCard extends StatefulWidget {
  final Meal meal;
  final DailyItems dailyItems;

  const YourMealsMenuCard(this.meal, this.dailyItems);

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
              MenuUIUtils.buildtitleAndBhawanNameComponent(_model.meal),
              SizedBox(width: 8),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            if (_model.isSwitchEnabled) ...[
              _buildQRButtonComponent(),
              _model.meal.items.isNotEmpty
                  ? _buildSwitchComponent()
                  : Container(),
            ],
            _buildSkippedFlagComponent(),
            SizedBox(width: 10),
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
                MenuUIUtils.buildMealItemsComponent(_model.meal),
              ],
            ),
          ),
          MenuUIUtils.buildDailyItemsComponent(
            _model.meal,
            widget.dailyItems,
          ),
          MenuUIUtils.buildSpecialMealBanner(
            _model.meal.costType,
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
                            _model.meal),
                      ],
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(_model.meal.startDateTime),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QRWidget(
            switchId: _model.meal.switchStatus.id,
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
    if (_model.meal.isOutdated) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () => Get.toNamed(NewFeedbackView.id),
          child: Image.asset(
            'assets/icons/feedback_button.png',
            height: 18,
            width: 18,
          ),
        ),
      );
    } else if (_model.isLeaveEnabled && !isCheckedOut) {
      return GestureDetector(
        onHorizontalDragStart: (_) => _model.onSwitchDragged(),
        child: Switch(
          activeColor: AppTheme.primary,
          value: _model.mealLeaveStatus,
          onChanged: (_model.isLeaveToggleOutdated || !_model.mealSwitchStatus)
              ? null
              : (value) {
                  _model.onLeaveChanged(value).then((_) {
                    context.read<YourMenuViewModel>().updateMeal =
                        _model.meal.copyWith(
                            leaveStatus: LeaveStatus(
                      status: _model.mealLeaveStatus
                          ? LeaveStatusEnum.N
                          : LeaveStatusEnum.P,
                    ));
                  });
                },
        ),
      );
    }
    return Container();
  }

  Widget _buildSwitchComponent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: _model.meal.isSwitchable
          ? GestureDetector(
              onTap: _model.onSwitchChanged,
              child: Image.asset(
                _model.meal.isLeaveToggleOutdated
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
                _model.meal.leaveStatus?.status) !=
            Colors.white &&
        _model.meal.isOutdated) {
      return Container(
        decoration: BoxDecoration(
          color: ColorUtils.getLeaveColorFromLeaveStatus(
              _model.meal.leaveStatus?.status),
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          'Skipped',
          style: AppTheme.bodyText2.copyWith(color: AppTheme.white),
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
              _model.meal.switchStatus,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: _model.meal.switchStatus.status == SwitchStatusEnum.N
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
        _model.isLeaveToggleOutdated =
            widget.meal?.isLeaveToggleOutdated ?? _model.isLeaveToggleOutdated;
        _model.updateMealLeaveAndSwitchStatus(_model.meal);
      },
      onDidUpdateWidget: (oldWidget, model) {
        _model.meal = widget.meal;
        _model.dailyItems = widget.dailyItems;
        _model.isLeaveToggleOutdated =
            widget.meal?.isLeaveToggleOutdated ?? _model.isLeaveToggleOutdated;
        _model.updateMealLeaveAndSwitchStatus(_model.meal);
      },
      builder: (context, model, child) {
        if (model.meal == null) return Container();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: _model.isSwitchEnabled && _model.secretCode != null
              ? _buildQRCard()
              : _buildMenuCard(),
        );
      },
    );
  }
}
