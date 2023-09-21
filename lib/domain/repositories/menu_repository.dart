import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MenuRepository {
  final ApiService _apiService;

  MenuRepository(this._apiService);

  // TODO: check correct input params for all functions

  Future<WeekMenu> weekMenuMultiMessing(String hostelCode, int id) async {
    try {
      WeekMenu? weekMenu;
      weekMenu = await _apiService.weekMenuMultimessing(hostelCode, id);
      return weekMenu;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw Failure(AppConstants.MENU_NOT_UPLOADED);
      } else {
        throw Failure(AppConstants.GENERIC_FAILURE);
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<WeekMenu> weekMenuForYourMeals(int weekId) async {
    try {
      WeekMenu? weekMenu;
      weekMenu = await _apiService.weekMenuForYourMeals(weekId);
      return weekMenu;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw Failure(AppConstants.MENU_NOT_UPLOADED);
      } else {
        throw Failure(AppConstants.GENERIC_FAILURE);
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // TODO: weekMenuFromDB()

  Future<WeekMenu> weekMenuByWeekId(int weekId) async {
    try {
      WeekMenu? weekMenu;
      weekMenu = await _apiService.weekMenuByWeekId(weekId);
      return weekMenu;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw Failure(AppConstants.MENU_NOT_UPLOADED);
      } else {
        throw Failure(AppConstants.GENERIC_FAILURE);
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<WeekMenu> currentWeekMenu() async {
    try {
      WeekMenu? weekMenu;
      weekMenu = await _apiService.currentWeekMenu();
      return weekMenu;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw Failure(AppConstants.MENU_NOT_UPLOADED);
      } else {
        throw Failure(AppConstants.GENERIC_FAILURE);
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<WeekMenu> dayMenu(int week, String dayOfWeek) async {
    try {
      WeekMenu? weekMenu;
      weekMenu = await _apiService.dayMenu(week, dayOfWeek);
      return weekMenu;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw Failure(AppConstants.MENU_NOT_UPLOADED);
      } else {
        throw Failure(AppConstants.GENERIC_FAILURE);
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
