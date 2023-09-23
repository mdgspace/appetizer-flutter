import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'week_menu_event.dart';
part 'week_menu_state.dart';

class WeekMenuBlocBloc extends Bloc<WeekMenuBlocEvent, WeekMenuBlocState> {
  final MenuRepository menuRepository;
  final LeaveRepository leaveRepository;
  final CouponRepository couponRepository;

  WeekMenuBlocBloc({
    required this.leaveRepository,
    required this.menuRepository,
    required this.couponRepository,
  }) : super(const WeekMenuBlocLoadingState()) {
    on<FetchWeekMenuData>(_onFetchWeekMenuData);
    on<NextWeekChangeEvent>(_onNextWeekChangeEvent);
    on<PreviousWeekChangeEvent>(_onPreviousWeekChangeEvent);
    on<DayChangeEvent>(_onDayChangeEvent);
    on<DateChangeEvent>(_onDateChangeEvent);
    on<MealLeaveEvent>(_onMealLeaveEvent);
    on<MealCouponEvent>(_onMealCouponEvent);
  }

  void _onDayChangeEvent(
      DayChangeEvent event, Emitter<WeekMenuBlocState> emit) {
    if (state is! WeekMenuBlocDisplayState) {
      return;
    }
    int dayNumber = getDayNumber(
        (state as WeekMenuBlocDisplayState).weekMenu, event.newDayIndex);
    emit((state as WeekMenuBlocDisplayState)
        .copyWith(currDayIndex: event.newDayIndex, dayNumber: dayNumber));
  }

  void _onPreviousWeekChangeEvent(
      PreviousWeekChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    emit(const WeekMenuBlocLoadingState());
    try {
      WeekMenu previousWeekMenu =
          await menuRepository.weekMenuByWeekId(event.previousWeekId);
      int dayNumber = getDayNumber(previousWeekMenu, 0);
      emit(WeekMenuBlocDisplayState(
          weekMenu: previousWeekMenu, currDayIndex: 0, dayNumber: dayNumber));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onNextWeekChangeEvent(
      NextWeekChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    emit(const WeekMenuBlocLoadingState());
    try {
      WeekMenu nextWeekMenu =
          await menuRepository.weekMenuByWeekId(event.nextWeekId);
      int dayNumber = getDayNumber(nextWeekMenu, 0);
      emit(WeekMenuBlocDisplayState(
          weekMenu: nextWeekMenu, currDayIndex: 0, dayNumber: dayNumber));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onFetchWeekMenuData(
      FetchWeekMenuData event, Emitter<WeekMenuBlocState> emit) async {
    try {
      WeekMenu weekMenu = await menuRepository.currentWeekMenu();
      int dayNumber = getDayNumber(weekMenu, DateTime.now().weekday % 7);
      emit(WeekMenuBlocDisplayState(
        weekMenu: weekMenu,
        currDayIndex: DateTime.now().day % 7,
        dayNumber: dayNumber,
      ));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onDateChangeEvent(
      DateChangeEvent event, Emitter<WeekMenuBlocState> emit) async {
    emit(const WeekMenuBlocLoadingState());
    try {
      WeekMenu weekMenu = await menuRepository.weekMenuByWeekId(event.weekId);
      int dayNumber = getDayNumber(weekMenu, event.dayIndex);
      emit(WeekMenuBlocDisplayState(
        weekMenu: weekMenu,
        currDayIndex: event.dayIndex,
        dayNumber: dayNumber,
      ));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  _onMealLeaveEvent(
      MealLeaveEvent event, Emitter<WeekMenuBlocState> emit) async {
    try {
      late LeaveStatusEnum newLeaveStatus;
      if (event.meal.leaveStatus.status == LeaveStatusEnum.P) {
        try {
          await leaveRepository.cancelLeave(event.meal);
          newLeaveStatus = LeaveStatusEnum.N;
        } catch (e) {
          newLeaveStatus = LeaveStatusEnum.P;
        }
      } else {
        try {
          await leaveRepository.applyLeave(event.meal);
          newLeaveStatus = LeaveStatusEnum.P;
        } catch (e) {
          newLeaveStatus = LeaveStatusEnum.N;
        }
      }
      WeekMenu weekMenu = (state as WeekMenuBlocDisplayState).weekMenu;
      int dayNumber = (state as WeekMenuBlocDisplayState).dayNumber;
      for (Meal meal in weekMenu.dayMenus[dayNumber].meals) {
        if (meal.id == event.meal.id) {
          meal.leaveStatus = LeaveStatus(status: newLeaveStatus);
        }
      }
      emit((state as WeekMenuBlocDisplayState).copyWith(weekMenu: weekMenu));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  _onMealCouponEvent(
      MealCouponEvent event, Emitter<WeekMenuBlocState> emit) async {
    try {
      late CouponStatus newCouponStatus;
      print('[TEST] ${event.coupon.status}');
      if (event.coupon.status == CouponStatusEnum.A) {
        try {
          newCouponStatus = await couponRepository.cancelCoupon(event.coupon);
        } catch (e) {
          newCouponStatus = event.coupon;
        }
      } else {
        try {
          // print('[TEST] apply for coupon');
          newCouponStatus = await couponRepository.applyForCoupon(event.mealId);
          newCouponStatus.status = (newCouponStatus.id != null)
              ? CouponStatusEnum.A
              : CouponStatusEnum.N;
          // print('[TEST] applied for coupon and got ${newCouponStatus.status}');
        } catch (e) {
          // print('[TEST] error in apply for coupon');
          newCouponStatus = event.coupon;
        }
      }
      print(
          '[TEST] newCouponStatus: ${newCouponStatus.status} and meal ${event.mealId}');
      WeekMenu weekMenu = (state as WeekMenuBlocDisplayState).weekMenu;
      int dayNumber = (state as WeekMenuBlocDisplayState).dayNumber;
      for (Meal meal in weekMenu.dayMenus[dayNumber].meals) {
        if (meal.id == event.mealId) {
          meal.couponStatus = newCouponStatus;
        }
      }
      emit((state as WeekMenuBlocDisplayState).copyWith(weekMenu: weekMenu));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  int getDayNumber(WeekMenu weekMenu, int dayIndex) {
    dayIndex = (dayIndex == 0) ? 7 : dayIndex;
    for (int i = 0; i < weekMenu.dayMenus.length; i++) {
      if (weekMenu.dayMenus[i].date.weekday == dayIndex) {
        return i;
      }
    }
    return -1;
  }
}
