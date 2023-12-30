import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requests.dart';
part 'responses.dart';
part 'leave_repository.g.dart';

class LeaveRepository {
  final ApiService _apiService;

  LeaveRepository(this._apiService);

  Future<int> remainingLeaves() async {
    try {
      final response = await _apiService.remainingLeaves();
      return response["count"]!;
    } catch (e) {
      // TODO: Handle error
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<PaginatedLeaves> getLeaves(int year, int month) async {
    try {
      dynamic response;
      if (month == 0) {
        response = await _apiService.getLeavesForYear(year);
      } else {
        response = await _apiService.getLeaves(year, month);
      }
      return response;
    } catch (e) {
      // TODO: Handle error
      return const PaginatedLeaves(
        count: 0,
        hasNext: false,
        hasPrevious: false,
        results: [],
      );
    }
  }

  Future<bool> checkout() async {
    Map<String, dynamic> map = {
      'is_checked_out': true,
    };
    try {
      final response = await _apiService.check(map);
      return response.isCheckedOut;
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<bool> checkin() async {
    Map<String, dynamic> map = {
      'is_checked_out': false,
    };
    try {
      final response = await _apiService.check(map);
      return response.isCheckedOut;
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  // TODO: check if Future or Future<void> or something else
  // TODO: confirm the input params
  Future applyLeave(Meal meal) async {
    Map<String, dynamic> map = {
      'meal': meal.id,
    };
    try {
      return await _apiService.leave(map);
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  // TODO: check if Future or Future<void> or something else
  // TODO: confirm the input params
  Future cancelLeave(Meal meal) async {
    try {
      return await _apiService.cancelLeave(meal.id);
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
