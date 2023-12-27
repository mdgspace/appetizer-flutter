import 'dart:async';

import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:appetizer/domain/repositories/transaction_repositroy.dart';
import 'package:appetizer/globals.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaves_and_rebate_event.dart';
part 'leaves_and_rebate_state.dart';

class LeavesAndRebateBloc
    extends Bloc<LeavesAndRebateEvent, LeavesAndRebateState> {
  final LeaveRepository leaveRepository;
  final TransactionRepository transactionRepository;

  LeavesAndRebateBloc({
    required this.leaveRepository,
    required this.transactionRepository,
  }) : super(LeavesAndRebateState.initial()) {
    on<FetchLeavesAndRebates>(_onFetchLeavesAndRebates);
  }

  FutureOr<void> _onFetchLeavesAndRebates(
      FetchLeavesAndRebates event, Emitter<LeavesAndRebateState> emit) async {
    PaginatedLeaves currYearLeaves =
        await leaveRepository.getLeaves(DateTime.now().year.toInt(), 0);
    int remainingLeaves = await leaveRepository.remainingLeaves();
    PaginatedYearlyRebate initialYearlyRebates =
        await transactionRepository.getYearlyRebates(
            DateTime(DateTime.now().year, DateTime.now().month - 1).year);
    emit(LeavesAndRebateState(
      remainingLeaves: remainingLeaves,
      mealsSkipped: maxLeaves - remainingLeaves,
      paginatedLeaves: currYearLeaves,
      initialPaginatedYearlyRebate: initialYearlyRebates,
      loading: false,
    ));
  }
}
