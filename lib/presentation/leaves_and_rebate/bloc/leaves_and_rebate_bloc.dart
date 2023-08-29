import 'dart:async';

import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaves_and_rebate_event.dart';
part 'leaves_and_rebate_state.dart';

class LeavesAndRebateBloc
    extends Bloc<LeavesAndRebateEvent, LeavesAndRebateState> {
  // final bool isCheckedOut;
  // final PaginatedLeaves currYearLeaves;
  // final int remainingLeaves, mealsSkipped;
  LeavesAndRebateBloc() : super(LeavesAndRebateState.initial()) {
    on<LeavesAndRebateToggleCheckOutStatusEvent>(_onToggleEvent);
  }

  FutureOr<void> _onToggleEvent(LeavesAndRebateToggleCheckOutStatusEvent event,
      Emitter<LeavesAndRebateState> emit) {
    emit(LeavesAndRebateState(
        isCheckedOut: !state.isCheckedOut,
        remainingLeaves: state.remainingLeaves,
        mealsSkipped: state.mealsSkipped,
        paginatedLeaves: state.paginatedLeaves));
  }
}
