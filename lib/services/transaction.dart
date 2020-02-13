import 'dart:convert';
import 'package:appetizer/models/transaction/current_month_rebate.dart';
import 'package:appetizer/models/transaction/yearly_rebate.dart';
import 'package:appetizer/models/transaction/faq.dart';
import 'package:http/http.dart' as http;

import '../globals.dart';

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
