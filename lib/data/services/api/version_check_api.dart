import 'dart:io' show Platform;

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/appetizer_version.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VersionCheckApi {
  var header = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<AppetizerVersion> checkVersion(String versionNumber) async {
    var platform = Platform.isAndroid ? 'an' : 'io';
    var endPoint = '/panel/version/expire/$platform/$versionNumber';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      var jsonResponse = await ApiUtils.get(uri, headers: header);
      var appiVersion = AppetizerVersion.fromJson(jsonResponse);
      return appiVersion;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
