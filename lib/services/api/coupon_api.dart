import 'package:appetizer_revamp_parts/config/environment_config.dart';
import 'package:appetizer_revamp_parts/constants.dart';
import 'package:appetizer_revamp_parts/models/failure_model.dart';
import 'package:appetizer_revamp_parts/models/menu/week_menu.dart';
import 'package:appetizer_revamp_parts/utils/api_utils.dart';
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
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
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
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
