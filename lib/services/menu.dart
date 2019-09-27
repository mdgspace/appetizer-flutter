import 'dart:convert';
import 'package:appetizer/models/menu/approve.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:http/http.dart' as http;

String url = "https://mess.iitr.ac.in";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Week> menuWeek(String token , int weekId) async {
  String endpoint = "/api/menu/week/?week_id=$weekId";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Week week = new Week.fromJson(jsonResponse);
    print(response.body);
    return week;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Week> menuWeekById(String token, String weekId, String year) async {
  String endpoint = "/api/menu/week/?week_id=$weekId&year=$year";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Week week = new Week.fromJson(jsonResponse);
    print(response.body);
    return week;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Day> menuDay(String token, int week, int dayOfWeek) async {
  String endpoint = "/api/menu/$week/$dayOfWeek";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Day day = new Day.fromJson(jsonResponse);
    print(response.body);
    return day;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Meal> menuMeal(
    String token, String week, String dayOfWeek, String meal) async {
  String endpoint = "/api/menu/$week/$dayOfWeek/$meal";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Meal meal = new Meal.fromJson(jsonResponse);
    print(response.body);
    return meal;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Meal> menuNextMeal(String token) async {
  String endpoint = "/api/menu/meal/next/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Meal meal = new Meal.fromJson(jsonResponse);
    print(response.body);
    return meal;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Meal> newMealItem(String token, String type, String name) async {
  String endpoint = "/api/menu/m/item/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  var json = {"type": type, "name": name};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body: json,
    );
    final jsonResponse = jsonDecode(response.body);
    Meal meal = new Meal.fromJson(jsonResponse);
    print(response.body);
    return meal;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Approve> weekApprove(
    String token, String weekId, bool isApproved, String year) async {
  String endpoint = "/api/menu/m/week/approve/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  var json = {"week_id": weekId, "is_approved": isApproved, "year": year};
  try {
    var response = await client.patch(
      uri,
      headers: tokenAuth,
      body: json,
    );
    final jsonResponse = jsonDecode(response.body);
    Approve approve = new Approve.fromJson(jsonResponse);
    print(response.body);
    return approve;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<List<MealItem>> allMealItems(String token) async {
  String endpoint = "/api/menu/m/items/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
      List<MealItem> mealItems = new List<MealItem>.from(jsonResponse);
    print(response.body);
    return mealItems;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
