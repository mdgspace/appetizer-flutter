import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/approve.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuApi {
  var headers = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<Week> menuWeekMultiMessing(int weekId, String hostelCode) async {
    String endpoint = "/api/menu/week/v2?hostel=$hostelCode&week_id=$weekId";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      Week week = new Week.fromJson(jsonResponse);
      return week;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Week> menuWeekForYourMeals(int weekId) async {
    String endpoint = "/api/menu/my_week/?week_id=$weekId";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      Week weekForYourMeals = new Week.fromJson(jsonResponse);
      return weekForYourMeals;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Week> menuWeekFromDb() async {
    const String MEAL_STORE_NAME = 'meals';

    // A Store with int keys and Map<String, dynamic> values.
    // This Store acts like a persistent map, values of which are Week objects converted to Map
    final _mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

    // Private getter to shorten the amount of code needed to get the
    // singleton instance of an opened database.
    Database _db = await AppDatabase.instance.database;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var record = await _mealStore.record(prefs.getInt("mealKey")).get(_db);
      return Week.fromJson(record);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Week> menuWeekById(String weekId, String year) async {
    String endpoint = "/api/menu/week/?week_id=$weekId&year=$year";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      Week week = new Week.fromJson(jsonResponse);
      return week;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Day> menuDay(int week, int dayOfWeek) async {
    String endpoint = "/api/menu/$week/$dayOfWeek";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      Day day = new Day.fromJson(jsonResponse);
      return day;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Meal> menuMeal(String week, String dayOfWeek, String meal) async {
    String endpoint = "/api/menu/$week/$dayOfWeek/$meal";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      Meal meal = new Meal.fromJson(jsonResponse);
      return meal;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Meal> menuNextMeal() async {
    String endpoint = "/api/menu/meal/next/";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      Meal meal = new Meal.fromJson(jsonResponse);
      return meal;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Meal> newMealItem(String type, String name) async {
    String endpoint = "/api/menu/m/item/";
    String uri = url + endpoint;
    var json = {"type": type, "name": name};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
        body: json,
      );
      Meal meal = new Meal.fromJson(jsonResponse);
      return meal;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Approve> weekApprove(
      String weekId, bool isApproved, String year) async {
    String endpoint = "/api/menu/m/week/approve/";
    String uri = url + endpoint;
    var json = {"week_id": weekId, "is_approved": isApproved, "year": year};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: json,
      );
      Approve approve = new Approve.fromJson(jsonResponse);
      return approve;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<MealItem>> allMealItems() async {
    String endpoint = "/api/menu/m/items/";
    String uri = url + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      List<MealItem> mealItems = new List<MealItem>.from(jsonResponse);
      return mealItems;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
