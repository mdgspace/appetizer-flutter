import 'dart:convert';
import 'package:appetizer/models/Transaction/currentMonthRebate.dart';
import 'package:appetizer/models/Transaction/yearlyReabte.dart';
import 'package:appetizer/models/Transaction/FAQ.dart';
import 'package:http/http.dart' as http;

String url = "http://appetizer-mdg.herokuapp.com";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<MonthlyRebate> getMonthlyLeave(String token) async {
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

Future<Faq> getFAQ(String token) async{
  String endPoint = "/api/transaction/api/faqs/";
  String uri = url + endPoint;

  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    Faq faq = new Faq.fromJson(jsonResponse);
    print(response.body);
    return faq;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
