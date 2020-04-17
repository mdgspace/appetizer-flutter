import 'package:appetizer/constants.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/leaves/create_leave.dart';
import 'package:appetizer/models/leaves/check.dart';
import 'package:appetizer/models/leaves/leave_list.dart';
import 'package:appetizer/models/leaves/remaining_leave_count.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class LeaveApi {
  var headers = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<LeaveCount> remainingLeaves() async {
    String endPoint = "/api/leave/count/remaining/";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      LeaveCount leaveCount = new LeaveCount.fromJson(jsonResponse);
      return leaveCount;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<LeaveList> leaveList(int year, int month) async {
    String endPoint;
    if (month == 0) {
      endPoint = "/api/leave/all/?year=$year";
    } else {
      endPoint = "/api/leave/all/?year=$year&month=$month";
    }
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      LeaveList leaveList = new LeaveList.fromJson(jsonResponse);
      return leaveList;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Check> check() async {
    String endPoint = "/api/leave/check/";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var json = {"is_checked_out": true};
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      Check check = new Check.fromJson(jsonResponse);
      return check;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<CreateLeave> leave(String id) async {
    String endPoint = "/api/leave/";
    String uri = url + endPoint;
    var json = {
      "meal": id,
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      CreateLeave leave = new CreateLeave.fromJson(jsonResponse);
      return leave;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<bool> cancelLeave(int id) async {
    String endPoint = "/api/leave/meal/$id";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      final response = await client.delete(uri, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 210) {
        return true;
      }
      return false;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
