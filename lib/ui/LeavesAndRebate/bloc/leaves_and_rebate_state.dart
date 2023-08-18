part of 'leaves_and_rebate_bloc.dart';

class LeavesAndRebateState extends Equatable {
  const LeavesAndRebateState(
      {required this.isCheckedOut,
      required this.mealsSkipped,
      required this.remainingLeaves,
      required this.paginatedLeaves});
  final bool isCheckedOut;
  final int remainingLeaves;
  final int mealsSkipped;
  final PaginatedLeaves paginatedLeaves;

  @override
  List<Object> get props =>
      [isCheckedOut, mealsSkipped, remainingLeaves, paginatedLeaves];
}
