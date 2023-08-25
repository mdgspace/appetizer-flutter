import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:flutter/foundation.dart';

class LeaveRepository {
  final ApiService _apiService;

  LeaveRepository(this._apiService);

  Future<int> remainingLeaves() async {
    try {
      return await _apiService.remainingLeaves();
    } catch (e) {
      // TODO: Handle error
      return 0;
    }
  }

  Future<PaginatedLeaves> getLeaves(int year, int month) async {
    try {
      if (month == 0) return await _apiService.getLeavesForYear(year);
      return await _apiService.getLeaves(year, month);
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
      return await _apiService.check(map);
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
      return await _apiService.check(map);
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
