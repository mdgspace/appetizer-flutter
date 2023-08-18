import 'package:appetizer_revamp_parts/models/leaves/paginated_leaves.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaves_and_rebate_event.dart';
part 'leaves_and_rebate_state.dart';

class LeavesAndRebateBloc
    extends Bloc<LeavesAndRebateEvent, LeavesAndRebateState> {
  final bool isCheckedOut;
  final PaginatedLeaves currYearLeaves;
  final int remainingLeaves, mealsSkipped;
  LeavesAndRebateBloc(
      {required this.isCheckedOut,
      required this.currYearLeaves,
      required this.mealsSkipped,
      required this.remainingLeaves})
      : super(LeavesAndRebateState(
            isCheckedOut: isCheckedOut,
            mealsSkipped: mealsSkipped,
            remainingLeaves: remainingLeaves,
            paginatedLeaves: currYearLeaves)) {
    on<LeavesAndRebateToggleCheckOutStatusEvent>(
        (LeavesAndRebateToggleCheckOutStatusEvent event,
            Emitter<LeavesAndRebateState> emit) {
      emit(LeavesAndRebateState(
          isCheckedOut: !isCheckedOut,
          remainingLeaves:
              state.remainingLeaves,
          mealsSkipped: state.mealsSkipped,
          paginatedLeaves:
              state.paginatedLeaves));
    });
  }
}
