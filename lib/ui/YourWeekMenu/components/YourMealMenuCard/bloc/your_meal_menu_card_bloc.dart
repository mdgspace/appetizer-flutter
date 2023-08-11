import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
part 'your_meal_menu_card_event.dart';
part 'your_meal_menu_card_state.dart';

class YourMealMenuCardBloc
    extends Bloc<YourMealMenuCardEvent, YourMealMenuCardState> {
  // final LeaveApi _leaveApi = locator<LeaveApi>();
  YourMealMenuCardBloc({required Meal meal})
      : super(YourMealMenuCardDisplayState(meal: meal)) {
    // final Meal meal;
    on<MealToggleEvent>(
        (MealToggleEvent event, Emitter<YourMealMenuCardState> emit) async {
      if (state is! YourMealMenuCardDisplayState) {
        return;
      }
      final Meal meal = (state as YourMealMenuCardDisplayState).meal;
      emit(YourMealMenuCardDisplayState(meal: meal));
      // if (meal.isLeaveToggleOutdated) return;
      // try {
      //   bool mealLeft = meal.leaveStatus.status == LeaveStatusEnum.A;
      //   // determine original state of meal
      //   if (!mealLeft) {
      //     dynamic leaveCreated = await _leaveApi.leave(meal.id.toString());
      //     if (leaveCreated == true) {
      //       // TODO: change required properties of meal
      //       // await Fluttertoast.showToast(msg: 'Meal Skipped');.
      //       emit(const ShowSnackBarState(text: "Meal left successfully"));
      //       emit(YourMealMenuCardDisplayState(meal: meal));
      //     }
      //   } else {
      //     try {
      //       bool isLeaveCancelled = await _leaveApi.cancelLeave(meal.id);
      //       if (isLeaveCancelled) {
      //         emit(const ShowSnackBarState(
      //             text: "Leave cancelled successfully"));
      //         emit(YourMealMenuCardDisplayState(meal: meal));
      //       }
      //     } on Failure catch (f) {
      //       emit(ShowSnackBarState(text: f.message));
      //       // TODO: change required properties of meal
      //     }
      //   }
      // } on Failure catch (f) {
      //   emit(
      //     ShowSnackBarState(text: "Error while toggling meal: ${f.message}"),
      //   );
      // }
    });
  }
}
