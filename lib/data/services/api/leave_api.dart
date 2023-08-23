import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LeaveApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<int> remainingLeaves() async {
    var endPoint = '/api/leave/count/remaining/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var count = jsonResponse['count'];
      return count;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<PaginatedLeaves> getLeaves(int year, int month) async {
    String endPoint;
    if (month == 0) {
      endPoint = '/api/leave/all/?year=$year';
    } else {
      endPoint = '/api/leave/all/?year=$year&month=$month';
    }
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var leaveList = PaginatedLeaves.fromJson(jsonResponse);
      return leaveList;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<bool> checkout() async {
    var endPoint = '/api/leave/check/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;
    var json = {'is_checked_out': true};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      var isCheckedOut = jsonResponse['is_checked_out'];
      return isCheckedOut;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<bool> checkin() async {
    var endPoint = '/api/leave/check/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;
    var json = {'is_checked_out': false};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      var isCheckedOut = jsonResponse['is_checked_out'];
      return isCheckedOut;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future leave(String id) async {
    var endPoint = '/api/leave/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;
    var json = {'meal': id};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      await ApiUtils.post(uri, headers: headers, body: json);
      return true;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<bool> cancelLeave(int id) async {
    var endPoint = '/api/leave/meal/$id';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      final response = await ApiUtils.delete(uri, headers: headers);
      return response == null;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
