import 'dart:async';

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hostel_change_event.dart';
part 'hostel_change_state.dart';

class HostelChangeBloc extends Bloc<HostelChangeEvent, HostelChangeState> {
  final UserRepository repo;
  HostelChangeBloc({required this.repo}) : super(const HostelChangeInitial()) {
    on<HostelChangePressed>(_onHostelChangePressed);
    on<HostelSearchQueryChanged>(_onHostelSearchQueryChanged);
  }

  FutureOr<void> _onHostelChangePressed(
      HostelChangePressed event, Emitter<HostelChangeState> emit) async {
    emit(Loading());
    String hostel = event.hostel;
    String roomNo = event.roomNo;
    if (hostel == "") {
      emit(const HostelChangeInitial(error: "Please select a hostel"));
      return;
    }
    if (roomNo == "") {
      emit(const HostelChangeInitial(error: "Please enter a room number"));
      if (hostel != "") emit(HostelQueryChanged(query: hostel));
      return;
    }
    try {
      await repo.postChangeHostel(hostel, roomNo);
      emit(HostelChangeSuccess());
    } catch (e) {
      emit(const HostelChangeInitial(error: AppConstants.GENERIC_FAILURE));
    }
  }

  FutureOr<void> _onHostelSearchQueryChanged(
      HostelSearchQueryChanged event, Emitter<HostelChangeState> emit) async {
    if (event.query == "") {
      emit(const HostelChangeInitial());
    } else {
      emit(Loading());
      emit(HostelQueryChanged(query: event.query));
    }
    // emit(const HostelChangeInitial());
  }
}
