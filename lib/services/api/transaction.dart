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
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<MonthlyRebate> getMonthlyRebate() async {
    var endPoint = '/api/transaction/rebate/current/';
    var uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var monthlyRebate = MonthlyRebate.fromJson(jsonResponse);
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
    var endPoint = '/api/transaction/list/expenses/?year=$year';
    var uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var yearlyRebate = YearlyRebate.fromJson(jsonResponse);
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
    var endPoint = '/api/faqs/';
    var uri = url + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var faqList = faqFromJson(json.encode(jsonResponse));
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
