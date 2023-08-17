part of 'leaves_and_rebate_bloc.dart';

abstract class LeavesAndRebateState extends Equatable {
  const LeavesAndRebateState();

  @override
  List<Object> get props => [];
}

class LeavesAndRebateDisplayState extends LeavesAndRebateState {
  const LeavesAndRebateDisplayState(
      {required this.isCheckedOut,
      required this.mealsSkipped,
      required this.remainingLeaves,
      required this.paginatedLeaves});
  final bool isCheckedOut;
  final int remainingLeaves;
  final int mealsSkipped;
  final PaginatedLeaves paginatedLeaves;

  @override
  List<Object> get props => [isCheckedOut];
}

class LeavesAndRebateLoadingState extends LeavesAndRebateState {
  const LeavesAndRebateLoadingState();

  @override
  List<Object> get props => [];
}
