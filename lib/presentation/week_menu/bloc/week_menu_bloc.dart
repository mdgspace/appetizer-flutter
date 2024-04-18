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
    on<CheckoutEvent>(_onCheckout);
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
        weekMenu: previousWeekMenu,
        currDayIndex: 0,
        dayNumber: dayNumber,
        jugaad: false,
      ));
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
        weekMenu: nextWeekMenu,
        currDayIndex: 0,
        dayNumber: dayNumber,
        jugaad: false,
      ));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onFetchWeekMenuData(
      FetchWeekMenuData event, Emitter<WeekMenuBlocState> emit) async {
    try {
      WeekMenu weekMenu = await menuRepository.currentWeekMenu();
      int dayNumber = getDayNumber(weekMenu, DateTime.now().weekday - 1);
      emit(WeekMenuBlocDisplayState(
        weekMenu: weekMenu,
        currDayIndex: DateTime.now().day - 1,
        dayNumber: dayNumber,
        jugaad: false,
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
        jugaad: false,
      ));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  _onMealLeaveEvent(
      MealLeaveEvent event, Emitter<WeekMenuBlocState> emit) async {
    try {
      late LeaveStatusEnum newLeaveStatus = event.meal.leaveStatus.status;
      late CouponStatus newCouponStatus = event.meal.couponStatus;
      if (event.meal.leaveStatus.status == LeaveStatusEnum.P) {
        try {
          await leaveRepository.cancelLeave(event.meal);
          newLeaveStatus = LeaveStatusEnum.N;
        } catch (e) {
          emit((state as WeekMenuBlocDisplayState)
              .copyWith(error: 'Something went wrong!'));
        }
      } else {
        try {
          await leaveRepository.applyLeave(event.meal);
          newLeaveStatus = LeaveStatusEnum.P;
          newCouponStatus = CouponStatus(status: CouponStatusEnum.N);
        } catch (e) {
          emit((state as WeekMenuBlocDisplayState)
              .copyWith(error: 'Something went wrong!'));
        }
      }
      WeekMenu weekMenu = (state as WeekMenuBlocDisplayState).weekMenu;
      int dayNumber = (state as WeekMenuBlocDisplayState).dayNumber;
      int length = weekMenu.dayMenus[dayNumber].meals.length;
      for (int index = 0; index < length; index++) {
        final meal = weekMenu.dayMenus[dayNumber].meals[index];
        if (meal.id == event.meal.id) {
          weekMenu.dayMenus[dayNumber].meals[index] = meal.copyWith(
            leaveStatus: LeaveStatus(status: newLeaveStatus),
            couponStatus: newCouponStatus,
          );
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
      if (event.coupon.status == CouponStatusEnum.A) {
        try {
          newCouponStatus = await couponRepository.cancelCoupon(event.coupon);
        } catch (e) {
          newCouponStatus = event.coupon;
        }
      } else {
        try {
          newCouponStatus = await couponRepository.applyForCoupon(event.mealId);
          newCouponStatus.status = (newCouponStatus.id != null)
              ? CouponStatusEnum.A
              : CouponStatusEnum.N;
        } catch (e) {
          newCouponStatus = event.coupon;
        }
      }
      WeekMenu weekMenu = (state as WeekMenuBlocDisplayState).weekMenu;
      int dayNumber = (state as WeekMenuBlocDisplayState).dayNumber;
      for (Meal meal in weekMenu.dayMenus[dayNumber].meals) {
        if (meal.id == event.mealId) {
          meal.couponStatus = newCouponStatus;
          if (meal.couponStatus.status == CouponStatusEnum.N) {
            emit((state as WeekMenuBlocDisplayState)
                .copyWith(error: "Time's up, coupon applications closed!"));
          }
        }
      }
      emit((state as WeekMenuBlocDisplayState).copyWith(weekMenu: weekMenu));
    } on Failure catch (e) {
      emit(WeekMenuErrorState(message: e.message));
    }
  }

  void _onCheckout(event, Emitter<WeekMenuBlocState> emit) {
    if (state is WeekMenuBlocDisplayState) {
      WeekMenu weekMenu = (state as WeekMenuBlocDisplayState).weekMenu;
      for (DayMenu menu in weekMenu.dayMenus) {
        for (Meal meal in menu.meals) {
          if (!meal.isLeaveToggleOutdated) {
            meal.couponStatus = CouponStatus(status: CouponStatusEnum.N);
          }
        }
      }
      emit((state as WeekMenuBlocDisplayState).copyWith(weekMenu: weekMenu));
    }
    emit(state);
  }

  int getDayNumber(WeekMenu weekMenu, int dayIndex) {
    for (int i = 0; i < weekMenu.dayMenus.length; i++) {
      if (weekMenu.dayMenus[i].date.weekday == dayIndex + 1) {
        return i;
      }
    }
    return -1;
  }
}
