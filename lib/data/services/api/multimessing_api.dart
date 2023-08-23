import 'dart:convert';

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/multimessing/switchable_meal.dart';
import 'package:appetizer/domain/models/multimessing/switch.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MultimessingApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<List<SwitchableMeal>> getSwitchableMeals(int id) async {
    var endpoint = '/api/menu/switch_meal/$id';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var switchableMeals = switchableMealsFromJson(json.encode(jsonResponse));
      return switchableMeals;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<int> remainingSwitches() async {
    var endPoint = '/api/leave/switch/count/remaining/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var switchCount = jsonResponse['switches'];
      return switchCount;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<bool> switchMeals(int mealId, String toHostel) async {
    var endPoint = '/api/leave/switch/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;
    var json = {
      'from_meal': mealId,
      'to_hostel': toHostel,
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var response = await client.post(Uri.parse(uri),
          headers: headers, body: jsonEncode(json));
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<bool> cancelSwitch(int id) async {
    var endPoint = '/api/leave/switch/$id';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      final response = await client.delete(Uri.parse(uri), headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 210) {
        return true;
      }
      return false;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<Switch> getSwitchDetails(int id) async {
    var endpoint = '/api/leave/switch/$id';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      final jsonResponse = await ApiUtils.get(uri, headers: headers);
      var switchDetails = Switch.fromJson(jsonResponse);
      return switchDetails;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<List<List<dynamic>>> switchableHostels() async {
    var endPoint = '/api/user/multimessing/hostels';
    var uri = EnvironmentConfig.BASE_URL + endPoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var switchableHostels = List<List<dynamic>>.from(
          jsonResponse.map((x) => List<dynamic>.from(x.map((x) => x))));
      return switchableHostels;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
