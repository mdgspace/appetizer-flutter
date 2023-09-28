part of 'week_menu_bloc.dart';

abstract class WeekMenuBlocEvent extends Equatable {
  const WeekMenuBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeekMenuData extends WeekMenuBlocEvent {
  const FetchWeekMenuData();
}

class DayChangeEvent extends WeekMenuBlocEvent {
  const DayChangeEvent({required this.newDayIndex});
  final int newDayIndex;

  @override
  List<Object> get props => [newDayIndex];
}

class NextWeekChangeEvent extends WeekMenuBlocEvent {
  const NextWeekChangeEvent({required this.nextWeekId});
  final int nextWeekId;

  @override
  List<Object> get props => [nextWeekId];
}

class PreviousWeekChangeEvent extends WeekMenuBlocEvent {
  const PreviousWeekChangeEvent({required this.previousWeekId});
  final int previousWeekId;

  @override
  List<Object> get props => [previousWeekId];
}

class DateChangeEvent extends WeekMenuBlocEvent {
  const DateChangeEvent({
    required this.dayIndex,
    required this.weekId,
  });

  final int dayIndex;
  final int weekId;

  @override
  List<Object> get props => [dayIndex, weekId];
}

class MealCouponEvent extends WeekMenuBlocEvent {
  const MealCouponEvent({
    required this.coupon,
    required this.mealId,
  });

  final CouponStatus coupon;
  final int mealId;

  @override
  List<Object> get props => [coupon, mealId];
}

class MealLeaveEvent extends WeekMenuBlocEvent {
  const MealLeaveEvent({
    required this.meal,
  });

  final Meal meal;

  @override
  List<Object> get props => [meal];
}

class CheckoutEvent extends WeekMenuBlocEvent {
  const CheckoutEvent();
}
