part of 'your_meal_menu_card_bloc.dart';

abstract class YourMealMenuCardState extends Equatable {
  const YourMealMenuCardState();

  @override
  List<Object> get props => [];
}

class YourMealMenuCardLoadingState extends YourMealMenuCardState{
  const YourMealMenuCardLoadingState();

  @override
  List<Object> get props => [];
}

class YourMealMenuCardDisplayState extends YourMealMenuCardState {
  const YourMealMenuCardDisplayState({required this.meal});
  final Meal meal;

  @override
  List<Object> get props => [meal];
}
