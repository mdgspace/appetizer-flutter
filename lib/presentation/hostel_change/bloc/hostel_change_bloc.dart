import 'dart:async';

import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/domain/models/user/user.dart';
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
    User user = await repo.getCurrentUser();
    int enrollmentNo = user.enrNo;
    print(enrollmentNo);
    String hostel = event.hostel;
    try {
      await repo.postChangeHostel(hostel);
      emit(HostelChangeSuccess());
    } catch (e) {
      emit(const HostelChangeInitial(error: AppConstants.GENERIC_FAILURE));
    }
  }

  FutureOr<void> _onHostelSearchQueryChanged(
      HostelSearchQueryChanged event, Emitter<HostelChangeState> emit) async {
    if (event.query == "" ) {
      emit(const HostelChangeInitial());
    } else {
      emit(Loading());
      emit(HostelQueryChanged(query: event.query));
    }
    // emit(const HostelChangeInitial());
  }
}
