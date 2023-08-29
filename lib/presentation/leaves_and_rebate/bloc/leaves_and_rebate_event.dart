part of 'leaves_and_rebate_bloc.dart';

abstract class LeavesAndRebateEvent extends Equatable {
  const LeavesAndRebateEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch data from remote
class FetchLeavesAndRebates extends LeavesAndRebateEvent {
  const FetchLeavesAndRebates();
}
