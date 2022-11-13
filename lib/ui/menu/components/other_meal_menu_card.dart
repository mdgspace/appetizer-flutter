import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/utils/menu_ui_utils.dart';
import 'package:appetizer/viewmodels/menu/other_menu_card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherMealsMenuCard extends StatefulWidget {
  final Meal? meal;
  final DailyItems dailyItems;

  OtherMealsMenuCard(this.meal, this.dailyItems);

  @override
  _OtherMealsMenuCardState createState() => _OtherMealsMenuCardState();
}

class _OtherMealsMenuCardState extends State<OtherMealsMenuCard> {
  late OtherMenuCardViewModel _model;

  Widget _buildSwitchIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => _model.onSwitchTapped(widget.meal!),
        child: Image.asset(
          widget.meal!.isLeaveToggleOutdated
              ? 'assets/icons/switch_inactive.png'
              : widget.meal!.switchStatus.status == SwitchStatusEnum.N
                  ? 'assets/icons/switch_active.png'
                  : 'assets/icons/switch_crossed_active.png',
          width: 30.r,
          scale: 2,
        ),
      ),
    );
  }

  Widget _buildMenuCardHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          child: MenuUIUtils.buildtitleAndBhawanNameComponent(widget.meal!),
        ),
        if (_model.isSwitchEnabled &&
            widget.meal!.items.isNotEmpty &&
            widget.meal!.isSwitchable)
          _buildSwitchIcon(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.meal == null) return Container();

    return BaseView<OtherMenuCardViewModel>(
      onModelReady: (model) => _model = model,
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Card(
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
                    MenuUIUtils.buildMealItemsComponent(widget.meal!),
                  ],
                ),
              ),
              MenuUIUtils.buildDailyItemsComponent(
                widget.meal!,
                widget.dailyItems,
              ),
              // MenuUIUtils.buildSpecialMealBanner(
              //   widget.meal.costType,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
