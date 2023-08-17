import 'package:appetizer_revamp_parts/globals.dart';
import 'package:appetizer_revamp_parts/locator.dart';
import 'package:appetizer_revamp_parts/models/leaves/paginated_leaves.dart';
import 'package:appetizer_revamp_parts/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer_revamp_parts/services/api/leave_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'leaves_and_rebate_event.dart';
part 'leaves_and_rebate_state.dart';

class LeavesAndRebateBloc
    extends Bloc<LeavesAndRebateEvent, LeavesAndRebateState> {
  final bool isCheckedOut;
  final LeaveApi _leaveApi = locator<LeaveApi>();
  LeavesAndRebateBloc({required this.isCheckedOut})
      : super(const LeavesAndRebateLoadingState()) {
    on<LeavesAndRebateGetInitialDataEvent>(
        (LeavesAndRebateGetInitialDataEvent event,
            Emitter<LeavesAndRebateState> emit) async {
      emit(const LeavesAndRebateLoadingState());
      final PaginatedLeaves paginatedLeaves =
          await _leaveApi.getLeaves(DateTime.now().year, 0);
      final int remainingLeaves = await _leaveApi.remainingLeaves();
      emit(LeavesAndRebateDisplayState(
          isCheckedOut: isCheckedOut,
          remainingLeaves: remainingLeaves,
          mealsSkipped: maxLeaves - remainingLeaves,
          paginatedLeaves: paginatedLeaves));
    });
    on<LeavesAndRebateToggleCheckOutStatusEvent>(
        (LeavesAndRebateToggleCheckOutStatusEvent event,
            Emitter<LeavesAndRebateState> emit) {
      emit(LeavesAndRebateDisplayState(
          isCheckedOut: !isCheckedOut,
          remainingLeaves:
              (state as LeavesAndRebateDisplayState).remainingLeaves,
          mealsSkipped: (state as LeavesAndRebateDisplayState).mealsSkipped,
          paginatedLeaves:
              (state as LeavesAndRebateDisplayState).paginatedLeaves));
    });
  }
}
