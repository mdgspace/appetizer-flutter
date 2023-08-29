part of 'leaves_and_rebate_bloc.dart';

class LeavesAndRebateState extends Equatable {
  const LeavesAndRebateState({
    required this.isCheckedOut,
    required this.mealsSkipped,
    required this.remainingLeaves,
    required this.loading,
    this.paginatedLeaves,
    this.initialPaginatedYearlyRebate,
  });
  final bool isCheckedOut;
  final int remainingLeaves;
  final int mealsSkipped;
  final PaginatedLeaves? paginatedLeaves;
  final PaginatedYearlyRebate? initialPaginatedYearlyRebate;
  final bool loading;

  factory LeavesAndRebateState.initial() {
    return const LeavesAndRebateState(
      isCheckedOut: false,
      mealsSkipped: 0,
      remainingLeaves: 0,
      loading: true,
    );
  }

  factory LeavesAndRebateState.initialWithCheckoutStatus(bool isCheckedOut) {
    return LeavesAndRebateState(
      isCheckedOut: isCheckedOut,
      mealsSkipped: 0,
      remainingLeaves: 0,
      loading: true,
    );
  }

  @override
  List<Object?> get props =>
      [isCheckedOut, mealsSkipped, remainingLeaves, paginatedLeaves, loading];
}
