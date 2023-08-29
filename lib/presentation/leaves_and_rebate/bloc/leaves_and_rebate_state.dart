part of 'leaves_and_rebate_bloc.dart';

class LeavesAndRebateState extends Equatable {
  const LeavesAndRebateState({
    required this.isCheckedOut,
    required this.mealsSkipped,
    required this.remainingLeaves,
    this.paginatedLeaves,
  });
  final bool isCheckedOut;
  final int remainingLeaves;
  final int mealsSkipped;
  final PaginatedLeaves? paginatedLeaves;

  factory LeavesAndRebateState.initial() {
    return const LeavesAndRebateState(
      isCheckedOut: false,
      mealsSkipped: 0,
      remainingLeaves: 0,
    );
  }

  @override
  List<Object?> get props =>
      [isCheckedOut, mealsSkipped, remainingLeaves, paginatedLeaves];
}
