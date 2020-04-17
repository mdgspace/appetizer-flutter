import 'dart:convert';
import 'dart:io';
import 'package:appetizer/constants.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiUtils {
  static http.Client client = new http.Client();

  /// Returns JSON GET response
  static Future<dynamic> get(String uri, {Map<String, String> headers}) async {
    try {
      final response = await client.get(uri, headers: headers);
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure(Constants.NO_INTERNET_CONNECTION);
    } on HttpException {
      throw Failure(Constants.HTTP_EXCEPTION);
    }
  }

  /// Returns JSON POST response
  static Future<dynamic> post(String uri,
      {Map<String, String> headers, dynamic body}) async {
    try {
      final response =
          await client.post(uri, headers: headers, body: jsonEncode(body));
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure(Constants.NO_INTERNET_CONNECTION);
    } on HttpException {
      throw Failure(Constants.HTTP_EXCEPTION);
    }
  }

  /// Returns JSON PUT response
  static Future<dynamic> put(String uri,
      {Map<String, String> headers, dynamic body}) async {
    try {
      final response = await client.put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure(Constants.NO_INTERNET_CONNECTION);
    } on HttpException {
      throw Failure(Constants.HTTP_EXCEPTION);
    }
  }

  /// Returns JSON PATCH response
  static Future<dynamic> patch(String uri,
      {Map<String, String> headers, dynamic body}) async {
    try {
      final response =
          await client.patch(uri, headers: headers, body: jsonEncode(body));
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure(Constants.NO_INTERNET_CONNECTION);
    } on HttpException {
      throw Failure(Constants.HTTP_EXCEPTION);
    }
  }

  /// Returns JSON DELETE response
  static Future<dynamic> delete(String uri,
      {Map<String, String> headers}) async {
    try {
      final response = await http.delete(uri, headers: headers);
      final jsonResponse = ApiUtils.jsonResponse(response);
      return jsonResponse;
    } on SocketException {
      throw Failure(Constants.NO_INTERNET_CONNECTION);
    } on HttpException {
      throw Failure(Constants.HTTP_EXCEPTION);
    }
  }

  static dynamic jsonResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 204:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorizedException(response.body);
      case 403:
        throw ForbiddenException(response.body);
      case 404:
        throw NotFoundException(response.body);
      case 409:
        throw ConflictException(response.body);
      case 500:
        throw InternalServerErrorException(response.body);
      case 503:
        throw ServiceUnavailableException(response.body);
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }

  static Future<void> addTokenToHeaders(Map<String, String> headers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    headers.addAll({"Authorization": "Token $token"});
  }
}
