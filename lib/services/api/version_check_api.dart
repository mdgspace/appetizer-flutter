// ignore_for_file: avoid_print

import 'dart:io' show Platform;

import 'package:appetizer/config/environment_config.dart';
import 'package:appetizer/constants.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/appetizer_version.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class VersionCheckApi {
  var header = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<AppetizerVersion> checkVersion(String versionNumber) async {
    var _platform = Platform.isAndroid ? 'an' : 'io';
    var endPoint = '/panel/version/expire/$_platform/$versionNumber';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      var jsonResponse = await ApiUtils.get(uri, headers: header);
      var appiVersion = AppetizerVersion.fromJson(jsonResponse);
      return appiVersion;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
