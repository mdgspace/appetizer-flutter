import 'dart:convert';
import 'package:appetizer/models/transaction/currentMonthRebate.dart';
import 'package:appetizer/models/transaction/yearlyRebate.dart';
import 'package:appetizer/models/transaction/FAQ.dart';
import 'package:http/http.dart' as http;

String url = "https://mess.iitr.ac.in";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<MonthlyRebate> getMonthlyRebate(String token) async {
  String endPoint = "/api/transaction/rebate/current/";
  String uri = url + endPoint;

  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    MonthlyRebate monthlyRebate = new MonthlyRebate.fromJson(jsonResponse);
    print(response.body);
    return monthlyRebate;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<YearlyRebate> getYearlyRebate(String token , int year) async{
  String endPoint = "/api/transaction/list/expenses/?year=$year";
  String uri = url + endPoint;

  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    YearlyRebate yearlyRebate = new YearlyRebate.fromJson(jsonResponse);
    print(response.body);
    return yearlyRebate;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<List<Faq>> getFAQ(String token) async{
  String endPoint = "/api/faqs/";
  String uri = url + endPoint;

  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    List<Faq> faqList = faqFromJson(response.body);
    print(response.body);
    return faqList;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
