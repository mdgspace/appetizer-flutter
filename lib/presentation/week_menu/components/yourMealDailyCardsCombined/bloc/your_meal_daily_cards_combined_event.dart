part of 'your_meal_daily_cards_combined_bloc.dart';

abstract class YourMealDailyCardsCombinedEvent extends Equatable {
  const YourMealDailyCardsCombinedEvent();

  @override
  List<Object> get props => [];
}

class ToggleMealLeaveEvent extends YourMealDailyCardsCombinedEvent {
  const ToggleMealLeaveEvent(
      {required this.mealId, required this.leaveAppliedAlready});
  final int mealId;
  final bool leaveAppliedAlready;

  @override
  List<Object> get props => [mealId];
}

class ToggleMealCouponEvent extends YourMealDailyCardsCombinedEvent {
  const ToggleMealCouponEvent(
      {required this.couponId,
      required this.couponAppliedAlready,
      required this.mealId});
  final int couponId;
  final int mealId;
  final bool couponAppliedAlready;
  @override
  List<Object> get props => [couponId, couponAppliedAlready, mealId];
}
