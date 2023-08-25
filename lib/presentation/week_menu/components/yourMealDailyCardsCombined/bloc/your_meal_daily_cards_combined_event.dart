part of 'your_meal_daily_cards_combined_bloc.dart';

abstract class YourMealDailyCardsCombinedEvent extends Equatable {
  const YourMealDailyCardsCombinedEvent();

  @override
  List<Object> get props => [];
}

class ToggleMealLeaveEvent extends YourMealDailyCardsCombinedEvent {
  const ToggleMealLeaveEvent({required this.meal});
  final Meal meal;

  @override
  List<Object> get props => [meal];
}

class ToggleMealCouponEvent extends YourMealDailyCardsCombinedEvent {
  const ToggleMealCouponEvent({
    required this.couponAppliedAlready,
    required this.coupon,
    required this.mealId,
  });
  final Coupon coupon;
  final bool couponAppliedAlready;
  final int mealId;
  @override
  List<Object> get props => [couponAppliedAlready, coupon];
}
