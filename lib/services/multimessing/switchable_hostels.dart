import 'package:appetizer/models/multimessing/switchable_hostels.dart';
import 'package:http/http.dart' as http;

String url = "https://appetizer-mdg.herokuapp.com";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<List<dynamic>>> switchableHostels(String token) async {
  String endPoint = "/api/user/multimessing/hostels";
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.get(uri, headers: tokenAuth);
    List<List<dynamic>> switchableHostels =
        switchableHostelsFromJson(response.body);
    print(response.body);
    return switchableHostels;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
