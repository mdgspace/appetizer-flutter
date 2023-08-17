import 'package:appetizer/locator.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/coupon_api.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'your_meal_daily_cards_combined_event.dart';
part 'your_meal_daily_cards_combined_state.dart';

class YourMealDailyCardsCombinedBloc extends Bloc<
    YourMealDailyCardsCombinedEvent, YourMealDailyCardsDisplayState> {
  YourMealDailyCardsCombinedBloc(List<MealState> mealStatesInitial)
      : super(YourMealDailyCardsDisplayState(mealStates: mealStatesInitial)) {
    // final CouponApi couponApi = locator<CouponApi>();
    // final LeaveApi leaveApi = locator<LeaveApi>();
    on<ToggleMealCouponEvent>((ToggleMealCouponEvent event,
        Emitter<YourMealDailyCardsDisplayState> emit) async {
      // late CouponStatus newCouponStatus;
      // late String text;
      // if (event.couponAppliedAlready) {
      //   newCouponStatus = await couponApi.cancelCoupon(event.couponId);
      //   text = "Coupon deselected successfully";
      // } else {
      //   newCouponStatus = await couponApi.applyForCoupon(event.mealId);
      //   text = "This coupon has been successfully allotted !";
      // }
      // List<MealState> oldState = state.mealStates;
      // List<MealState> newStates = [];
      // for (MealState mealState in oldState) {
      //   if (mealState.mealId == event.mealId) {
      //     newStates.add(mealState.copyWith(
      //         couponApplied: newCouponStatus.status == CouponStatusEnum.A));
      //   } else {
      //     newStates.add(mealState);
      //   }
      // }
      // // TODO: show dialog box using "text" variable
      // emit(YourMealDailyCardsDisplayState(mealStates: newStates));
    });
    on<ToggleMealLeaveEvent>((ToggleMealLeaveEvent event,
        Emitter<YourMealDailyCardsDisplayState> emit) async {
      // late bool newLeaveStatus;
      // if (event.leaveAppliedAlready) {
      //   newLeaveStatus = (await leaveApi.cancelLeave(event.mealId)) == false;
      // } else {
      //   newLeaveStatus =
      //       (await leaveApi.leave(event.mealId.toString())) == true;
      // }
      // List<MealState> oldState = state.mealStates;
      // List<MealState> newStates = [];
      // for (MealState mealState in oldState) {
      //   if (mealState.mealId == event.mealId) {
      //     newStates
      //         .add(mealState.copyWith(leaveAppliedAndApproved: newLeaveStatus));
      //   } else {
      //     newStates.add(mealState);
      //   }
      // }
      // emit(YourMealDailyCardsDisplayState(mealStates: newStates));
    });
  }
}
