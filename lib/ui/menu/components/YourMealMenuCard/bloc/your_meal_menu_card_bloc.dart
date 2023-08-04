import 'package:appetizer_revamp_parts/locator.dart';
import 'package:appetizer_revamp_parts/models/failure_model.dart';
import 'package:appetizer_revamp_parts/models/menu/week_menu.dart';
import 'package:appetizer_revamp_parts/services/api/leave_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'your_meal_menu_card_event.dart';
part 'your_meal_menu_card_state.dart';

class YourMealMenuCardBloc
    extends Bloc<YourMealMenuCardEvent, YourMealMenuCardState> {
  final LeaveApi _leaveApi = locator<LeaveApi>();
  YourMealMenuCardBloc() : super(const YourMealMenuCardLoadingState()) {
    on<MealToggleEvent>(
        (MealToggleEvent event, Emitter<YourMealMenuCardState> emit) async {
      if (state is! YourMealMenuCardDisplayState) {
        return;
      }
      final Meal meal = (state as YourMealMenuCardDisplayState).meal;
      if (meal.isLeaveToggleOutdated) return;
      // try {
      //   dynamic leaveCreated = await _leaveApi.leave(meal.id.toString());
      //   if (leaveCreated == true) {
      //     await Fluttertoast.showToast(msg: 'Meal Skipped');
      //   }
      // } on Failure catch (f) {
      //   // setState(ViewState.Error);
      //   // setErrorMessage(f.message);
      //   await Fluttertoast.showToast(msg: "Error skipping meal, please try again");
      //   meal.leaveStatus = !meal.leaveStatus;
      // }
    });
  }
}
