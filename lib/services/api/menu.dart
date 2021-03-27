import 'package:appetizer/config/environment_config.dart';
import 'package:appetizer/constants.dart';
import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/approve.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<Week> menuWeekMultiMessing(int weekId, String hostelCode) async {
    var endpoint = '/api/menu/week/v2?hostel=$hostelCode&week_id=$weekId';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var week = Week.fromJson(jsonResponse);
      return week;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Week> menuWeekForYourMeals(int weekId) async {
    var endpoint = '/api/menu/my_week/?week_id=$weekId';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var weekForYourMeals = Week.fromJson(jsonResponse);
      return weekForYourMeals;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Week> menuWeekFromDb() async {
    const MEAL_STORE_NAME = 'meals';

    // A Store with int keys and Map<String, dynamic> values.
    // This Store acts like a persistent map, values of which are Week objects converted to Map
    final _mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

    // Private getter to shorten the amount of code needed to get the
    // singleton instance of an opened database.
    var _db = await AppDatabase.instance.database;

    try {
      var prefs = await SharedPreferences.getInstance();
      var record = await _mealStore.record(prefs.getInt('mealKey')).get(_db);
      return Week.fromJson(record);
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Week> menuWeekById(String weekId, String year) async {
    var endpoint = '/api/menu/week/?week_id=$weekId&year=$year';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var week = Week.fromJson(jsonResponse);
      return week;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Day> menuDay(int week, int dayOfWeek) async {
    var endpoint = '/api/menu/$week/$dayOfWeek';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var day = Day.fromJson(jsonResponse);
      return day;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Meal> menuMeal(String week, String dayOfWeek, String meal) async {
    var endpoint = '/api/menu/$week/$dayOfWeek/$meal';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var meal = Meal.fromJson(jsonResponse);
      return meal;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Meal> menuNextMeal() async {
    var endpoint = '/api/menu/meal/next/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var meal = Meal.fromJson(jsonResponse);
      return meal;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Meal> newMealItem(String type, String name) async {
    var endpoint = '/api/menu/m/item/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {'type': type, 'name': name};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
        body: json,
      );
      var meal = Meal.fromJson(jsonResponse);
      return meal;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Approve> weekApprove(
      String weekId, bool isApproved, String year) async {
    var endpoint = '/api/menu/m/week/approve/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {'week_id': weekId, 'is_approved': isApproved, 'year': year};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: json,
      );
      var approve = Approve.fromJson(jsonResponse);
      return approve;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<MealItem>> allMealItems() async {
    var endpoint = '/api/menu/m/items/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var mealItems = List<MealItem>.from(jsonResponse);
      return mealItems;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
