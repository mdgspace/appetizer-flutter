import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MenuRepository {
  final ApiService _apiService;

  MenuRepository(this._apiService);

  // TODO: check correct input params for all functions

  Future<WeekMenu> weekMenuMultiMessing(String hostelCode, int id) async {
    try {
      late WeekMenu weekMenu;
      _apiService.weekMenuMultimessing(hostelCode, id).then((weekMenuObj) {
        weekMenu = weekMenuObj;
      }).catchError((obj) {
        final res = (obj as DioException).response;
        if (res!.statusCode != 404) {
          throw Failure(AppConstants.MENU_NOT_UPLOADED);
        }
        throw Failure(AppConstants.GENERIC_FAILURE);
      });
      return weekMenu;
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<WeekMenu> weekMenuForYourMeals(int weekId) async {
    try {
      late WeekMenu weekMenu;
      _apiService.weekMenuForYourMeals(weekId).then((weekMenuObj) {
        weekMenu = weekMenuObj;
      }).catchError((obj) {
        final res = (obj as DioException).response;
        if (res!.statusCode != 404) {
          throw Failure(AppConstants.MENU_NOT_UPLOADED);
        }
        throw Failure(AppConstants.GENERIC_FAILURE);
      });
      return weekMenu;
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // TODO: weekMenuFromDB()

  Future<WeekMenu> weekMenuByWeekId(int weekId) async {
    try {
      late WeekMenu weekMenu;
      _apiService.weekMenuByWeekId(weekId).then((weekMenuObj) {
        weekMenu = weekMenuObj;
      }).catchError((obj) {
        final res = (obj as DioException).response;
        if (res!.statusCode != 404) {
          throw Failure(AppConstants.MENU_NOT_UPLOADED);
        }
        throw Failure(AppConstants.GENERIC_FAILURE);
      });
      return weekMenu;
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<WeekMenu> currentWeekMenu() async {
    try {
      late WeekMenu weekMenu;
      _apiService.currentWeekMenu().then((weekMenuObj) {
        weekMenu = weekMenuObj;
      }).catchError((obj) {
        final res = (obj as DioException).response;
        if (res!.statusCode != 404) {
          throw Failure(AppConstants.MENU_NOT_UPLOADED);
        }
        throw Failure(AppConstants.GENERIC_FAILURE);
      });
      return weekMenu;
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<WeekMenu> dayMenu(int week, String dayOfWeek) async {
    try {
      late WeekMenu weekMenu;
      _apiService.dayMenu(week, dayOfWeek).then((weekMenuObj) {
        weekMenu = weekMenuObj;
      }).catchError((obj) {
        final res = (obj as DioException).response;
        if (res!.statusCode != 404) {
          throw Failure(AppConstants.MENU_NOT_UPLOADED);
        }
        throw Failure(AppConstants.GENERIC_FAILURE);
      });
      return weekMenu;
    } on Failure catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
