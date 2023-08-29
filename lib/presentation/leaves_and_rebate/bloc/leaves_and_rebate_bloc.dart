import 'dart:async';

import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/repositories/leave_repository.dart';
import 'package:appetizer/globals.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaves_and_rebate_event.dart';
part 'leaves_and_rebate_state.dart';

class LeavesAndRebateBloc
    extends Bloc<LeavesAndRebateEvent, LeavesAndRebateState> {
  final bool isCheckedOut;
  final LeaveRepository leaveRepository;
  LeavesAndRebateBloc({required this.leaveRepository, required this.isCheckedOut}) : super(LeavesAndRebateState.initialWithCheckoutStatus(isCheckedOut)) {
    on<FetchLeavesAndRebates>(_onFetchLeavesAndRebates);
  }

  FutureOr<void> _onFetchLeavesAndRebates(
      FetchLeavesAndRebates event, Emitter<LeavesAndRebateState> emit) async {
    PaginatedLeaves currYearLeaves = await leaveRepository.getLeaves(DateTime.now().year, 0);
    int remainingLeaves = await leaveRepository.remainingLeaves();
    emit(LeavesAndRebateState(
      isCheckedOut: state.isCheckedOut,
      remainingLeaves: remainingLeaves,
      mealsSkipped: maxLeaves - remainingLeaves,
      paginatedLeaves: currYearLeaves,
      loading: false,
    ));
  }
}
