import 'dart:convert';

import 'package:appetizer/constants.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/transaction/current_month_rebate.dart';
import 'package:appetizer/models/transaction/yearly_rebate.dart';
import 'package:appetizer/models/transaction/faq.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class TransactionApi {
  var headers = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<MonthlyRebate> getMonthlyRebate() async {
    String endPoint = "/api/transaction/rebate/current/";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      MonthlyRebate monthlyRebate = new MonthlyRebate.fromJson(jsonResponse);
      return monthlyRebate;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<YearlyRebate> getYearlyRebate(int year) async {
    String endPoint = "/api/transaction/list/expenses/?year=$year";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      YearlyRebate yearlyRebate = new YearlyRebate.fromJson(jsonResponse);
      return yearlyRebate;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<Faq>> getFAQ() async {
    String endPoint = "/api/faqs/";
    String uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      List<Faq> faqList = faqFromJson(json.encode(jsonResponse));
      return faqList;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
