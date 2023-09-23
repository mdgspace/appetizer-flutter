import 'dart:developer';

import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
      print('[TEST] coupon ${event.coupon.id} and meal ${event.mealId}');
      if (event.couponAppliedAlready) {
        print('[TEST] coupon already applied');
        newCouponStatus = await couponRepository.cancelCoupon(event.coupon);
        text = "Coupon no. ${event.coupon.id} has been deselected";
      } else {
        print('[TEST] coupon not applied');
        newCouponStatus =  await couponRepository.applyForCoupon(event.mealId);
        text = "Coupon no. ${event.mealId} has been claimed successfully";
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
      late bool newLeaveStatus, newCouponStatus;
      late bool leaveAppliedStatus;
      for (int i = 0; i < state.mealStates.length; i++) {
        if (state.mealStates[i].mealId == event.meal.id) {
          leaveAppliedStatus = state.mealStates[i].leaveAppliedAndApproved;
          newCouponStatus = state.mealStates[i].couponApplied;
        }
      }
      debugPrint(
          'leaveAppliedStatus: $leaveAppliedStatus and mealId ${event.meal.id}');
      if (leaveAppliedStatus == true) {
        try {
          await leaveRepository.cancelLeave(event.meal);
          newLeaveStatus = false;
        } catch (e) {
          newLeaveStatus = leaveAppliedStatus;
        }
      } else {
        try {
          await leaveRepository.applyLeave(event.meal);
          newLeaveStatus = true;
          newCouponStatus = false;
        } catch (e) {
          newLeaveStatus = leaveAppliedStatus;
        }
      }
      List<MealState> oldState = state.mealStates;
      List<MealState> newStates = [];
      for (MealState mealState in oldState) {
        if (mealState.mealId == event.meal.id) {
          newStates.add(mealState.copyWith(
              leaveAppliedAndApproved: newLeaveStatus,
              couponApplied: newCouponStatus));
        } else {
          newStates.add(mealState);
        }
      }
      emit(YourMealDailyCardsDisplayState(mealStates: newStates));
    });
  }
}
