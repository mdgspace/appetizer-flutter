part of 'leaves_and_rebate_bloc.dart';

class LeavesAndRebateState extends Equatable {
  const LeavesAndRebateState({
    required this.mealsSkipped,
    required this.remainingLeaves,
    required this.loading,
    this.paginatedLeaves,
    this.initialPaginatedYearlyRebate,
  });

  final int remainingLeaves;
  final int mealsSkipped;
  final PaginatedLeaves? paginatedLeaves;
  final PaginatedYearlyRebate? initialPaginatedYearlyRebate;
  final bool loading;

  factory LeavesAndRebateState.initial() {
    return const LeavesAndRebateState(
      mealsSkipped: 0,
      remainingLeaves: 0,
      loading: true,
    );
  }

  @override
  List<Object?> get props =>
      [mealsSkipped, remainingLeaves, paginatedLeaves, loading];
}
