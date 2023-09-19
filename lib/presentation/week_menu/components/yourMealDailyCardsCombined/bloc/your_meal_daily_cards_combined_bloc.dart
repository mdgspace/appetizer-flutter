import 'dart:developer';

import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'your_meal_daily_cards_combined_event.dart';
part 'your_meal_daily_cards_combined_state.dart';

class YourMealDailyCardsCombinedBloc extends Bloc<
    YourMealDailyCardsCombinedEvent, YourMealDailyCardsDisplayState> {
  final CouponRepository couponRepository;
  final LeaveRepository leaveRepository;
  final List<MealState> mealStatesInitial;
  YourMealDailyCardsCombinedBloc({
    required this.couponRepository,
    required this.leaveRepository,
    required this.mealStatesInitial,
  }) : super(YourMealDailyCardsDisplayState(mealStates: mealStatesInitial)) {
    on<ToggleMealCouponEvent>((ToggleMealCouponEvent event,
        Emitter<YourMealDailyCardsDisplayState> emit) async {
      late CouponStatus newCouponStatus;
      late String text;
      if (event.couponAppliedAlready) {
        newCouponStatus = await couponRepository.cancelCoupon(event.coupon);
        text = "Coupon no. ${event.coupon.id} has been deselected";
      } else {
        newCouponStatus = await couponRepository.applyForCoupon(event.coupon);
        text = "Coupon no. ${event.coupon.id} has been claimed successfully";
      }
      List<MealState> oldState = state.mealStates;
      List<MealState> newStates = [];
      for (MealState mealState in oldState) {
        if (mealState.mealId == event.mealId) {
          newStates.add(mealState.copyWith(
              couponApplied: newCouponStatus.status == CouponStatusEnum.A));
        } else {
          newStates.add(mealState);
        }
      }
      // TODO: show dialog box using "text" variable
      log(text);
      emit(YourMealDailyCardsDisplayState(mealStates: newStates));
    });
    on<ToggleMealLeaveEvent>((ToggleMealLeaveEvent event,
        Emitter<YourMealDailyCardsDisplayState> emit) async {
      late bool newLeaveStatus;
      if (event.meal.leaveStatus.status == LeaveStatusEnum.A) {
        newLeaveStatus =
            (await leaveRepository.cancelLeave(event.meal)) == false;
      } else {
        newLeaveStatus = (await leaveRepository.applyLeave(event.meal)) == true;
      }
      List<MealState> oldState = state.mealStates;
      List<MealState> newStates = [];
      for (MealState mealState in oldState) {
        if (mealState.mealId == event.meal.id) {
          newStates
              .add(mealState.copyWith(leaveAppliedAndApproved: newLeaveStatus));
        } else {
          newStates.add(mealState);
        }
      }
      emit(YourMealDailyCardsDisplayState(mealStates: newStates));
    });
  }
}
