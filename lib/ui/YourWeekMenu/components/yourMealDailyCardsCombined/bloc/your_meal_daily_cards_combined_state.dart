part of 'your_meal_daily_cards_combined_bloc.dart';

class MealState {
  const MealState(
      {required this.mealId,
      required this.leaveAppliedAndApproved,
      required this.couponApplied});

  final int mealId;
  final bool couponApplied, leaveAppliedAndApproved;

  MealState copyWith({bool? couponApplied, bool? leaveAppliedAndApproved}) {
    return MealState(
      mealId: mealId,
      leaveAppliedAndApproved:
          leaveAppliedAndApproved ?? this.leaveAppliedAndApproved,
      couponApplied: couponApplied ?? this.couponApplied,
    );
  }
}

class YourMealDailyCardsDisplayState extends Equatable {
  const YourMealDailyCardsDisplayState({required this.mealStates});

  final List<MealState> mealStates;

  @override
  List<Object> get props => [mealStates];
}
