import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:appetizer/utils/app_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MenuApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<WeekMenu> weekMenuMultiMessing(int weekId, String hostelCode) async {
    var endpoint = '/api/menu/week/v2?hostel=$hostelCode&week_id=$weekId';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var weekMenu = WeekMenu.fromJson(jsonResponse);
      return weekMenu;
    } on NotFoundException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.MENU_NOT_FOUND);
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<WeekMenu> weekMenuForYourMeals(int weekId) async {
    var endpoint = '/api/menu/my_week/?week_id=$weekId';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var weekMenu = WeekMenu.fromJson(jsonResponse);
      return weekMenu;
    } on NotFoundException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.MENU_NOT_FOUND);
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<WeekMenu> weekMenuFromDb() async {
    // const MEAL_STORE_NAME = 'meals';

    // A Store with int keys and Map<String, dynamic> values.
    // This Store acts like a persistent map, values of which are Week objects converted to Map
    // final mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

    // Private getter to shorten the amount of code needed to get the
    // singleton instance of an opened database.
    // var db = await AppDatabase.instance.database;

    try {
      // var prefs = await SharedPreferences.getInstance();
      // var record = await mealStore.record(prefs.getInt('mealKey')!).get(db);
      // return WeekMenu.fromJson(record!);
      // TODO: Implement using Hive
      throw NotFoundException("not implemented yet");
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<WeekMenu> weekMenuByWeekId(int weekId) async {
    var endpoint = '/api/menu/week/?week_id=$weekId';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var weekMenu = WeekMenu.fromJson(jsonResponse);
      return weekMenu;
    } on NotFoundException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.MENU_NOT_FOUND);
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<WeekMenu> currentWeekMenu() async {
    var endpoint = '/api/menu/week/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var weekMenu = WeekMenu.fromJson(jsonResponse);
      return weekMenu;
    } on NotFoundException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.MENU_NOT_FOUND);
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<DayMenu> dayMenu(int week, int dayOfWeek) async {
    var endpoint = '/api/menu/$week/$dayOfWeek';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var dayMenu = DayMenu.fromJson(jsonResponse);
      return dayMenu;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
