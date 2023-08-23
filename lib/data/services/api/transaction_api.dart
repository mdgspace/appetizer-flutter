import 'dart:convert';

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/domain/models/transaction/faq.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TransactionApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<int> getMonthlyRebate() async {
    var endPoint = '/api/transaction/rebate/current/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var monthlyRebate = jsonResponse['rebate'];
      return monthlyRebate;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<PaginatedYearlyRebate> getYearlyRebate(int year) async {
    var endPoint = '/api/transaction/list/expenses/?year=$year';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var paginatedYearlyRebate = PaginatedYearlyRebate.fromJson(jsonResponse);
      return paginatedYearlyRebate;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<List<Faq>> getFAQ() async {
    var endPoint = '/api/faqs/';
    var uri = EnvironmentConfig.BASE_URL + endPoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var faqList = faqFromJson(json.encode(jsonResponse));
      return faqList;
    } on FormatException catch (e) {
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
