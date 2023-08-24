import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';

class MenuRepository {
  ApiService _apiService;

  MenuRepository(this._apiService);

  // TODO: check correct input params for all functions

  Future<WeekMenu> weekMenuMultiMessing(String hostelCode, int id) async {
    try {
      return await _apiService.weekMenuMultimessing(hostelCode, id);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<WeekMenu> weekMenuForYourMeals(int weekId) async {
    try {
      return await _apiService.weekMenuForYourMeals(weekId);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  // TODO: weekMenuFromDB()

  Future<WeekMenu> weekMenuByWeekId(int weekId) async {
    try {
      return await _apiService.weekMenuByWeekId(weekId);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<WeekMenu> currentWeekMenu() async {
    try {
      return await _apiService.currentWeekMenu();
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<WeekMenu> dayMenu(int week, String dayOfWeek) async {
    try {
      return await _apiService.dayMenu(week, dayOfWeek);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
