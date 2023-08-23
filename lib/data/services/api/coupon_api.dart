import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CouponApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<CouponStatus> applyForCoupon(int mealId) async {
    var endpoint = '/api/coupon/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(uri,
          headers: headers, body: {'meal': mealId, 'is_active': true});

      return CouponStatus(
        status: CouponStatusEnum.A,
        id: jsonResponse['id'],
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<CouponStatus> cancelCoupon(int couponId) async {
    var endpoint = '/api/coupon/$couponId';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      await ApiUtils.patch(uri, headers: headers, body: {'is_active': false});

      return CouponStatus(status: CouponStatusEnum.N);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}