part of 'your_meal_menu_card_bloc.dart';

abstract class YourMealMenuCardEvent extends Equatable {
  const YourMealMenuCardEvent();

  @override
  List<Object> get props => [];
}

class MealToggleEvent extends YourMealMenuCardEvent {
  const MealToggleEvent({required this.context});
  final BuildContext context;

  @override
  List<Object> get props => [];
}
