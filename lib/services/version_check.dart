import 'dart:convert';
import 'dart:io' show Platform;

import 'package:appetizer/models/version_check.dart';
import 'package:http/http.dart' as http;

String url = "https://appetizer-mdg.herokuapp.com";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<VersionCheck> checkVersion(String versionNumber) async {
  String _platform = Platform.isAndroid ? "an" : "io";
  String endPoint = "/panel/version/expire/$_platform/$versionNumber";
  String uri = url + endPoint;

  try {
    var response = await client.get(uri, headers: header);
    final jsonResponse = jsonDecode(response.body);
    VersionCheck versionCheck = new VersionCheck.fromJson(jsonResponse);
    print(response.body);
    return versionCheck;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
