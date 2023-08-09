import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaves_and_rebate_event.dart';
part 'leaves_and_rebate_state.dart';

class LeavesAndRebateBloc
    extends Bloc<LeavesAndRebateEvent, LeavesAndRebateState> {
  final bool isCheckedOut;
  LeavesAndRebateBloc({required this.isCheckedOut})
      : super(const LeavesAndRebateLoadingState()) {
    on<LeavesAndRebateGetInitialDataEvent>(
        (LeavesAndRebateGetInitialDataEvent event,
            Emitter<LeavesAndRebateState> emit) {
      emit(LeavesAndRebateDisplayState(
          isCheckedOut: isCheckedOut));
    });
    on<LeavesAndRebateToggleCheckOutStatusEvent>(
        (LeavesAndRebateToggleCheckOutStatusEvent event,
            Emitter<LeavesAndRebateState> emit) {
      emit(LeavesAndRebateDisplayState(isCheckedOut: !isCheckedOut));
    });
  }
}
