import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:flutter/foundation.dart';

class CouponRepository {
  final ApiService _apiService;

  CouponRepository(this._apiService);

  Future<CouponStatus> applyForCoupon(int mealId) async {
    Map<String, dynamic> map = {
      'meal': mealId,
      'is_active': true,
    };
    try {
      return await _apiService.applyForCoupon(map);
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<CouponStatus> cancelCoupon(CouponStatus coupon) async {
    Map<String, dynamic> map = {
      'is_active': false,
    };
    try {
      return await _apiService.cancelCoupon(coupon.id!, map);
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<List<Coupon>> getAllCoupon() async {
    try {
      return await _apiService.getAllCoupon();
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
