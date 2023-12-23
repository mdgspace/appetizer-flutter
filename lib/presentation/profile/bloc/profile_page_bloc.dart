import 'dart:async';

import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserRepository repo;
  ProfilePageBloc({required this.repo})
      : super(const ProfilePageInitialState()) {
    on<FetchProfile>(_onFetch);
    on<DeleteHostelChangeRequest>(_onDeleteHostelChangeRequest);
  }

  void _onFetch(FetchProfile event, Emitter<ProfilePageState> emit) async {
    // TODO: implement event handler
    User user = await repo.getCurrentUser();
    try {
      dynamic hostelChangeStatus = await repo.getHostelChangeStatus();
      emit(
        ProfilePageFetchedState(
            user: user, hostelChangeStatus: hostelChangeStatus),
      );
    } catch (e) {
      emit(
        ProfilePageFetchedState(
            user: user, hostelChangeStatus: const {'detail': 'No Request'}),
      );
    }
  }

  FutureOr<void> _onDeleteHostelChangeRequest(
      DeleteHostelChangeRequest event, Emitter<ProfilePageState> emit) async {
    emit(const ProfilePageInitialState());
    User user = await repo.getCurrentUser();
    dynamic hostelChangeStatus = await repo.deleteChangeHostel();
    emit(
      ProfilePageFetchedState(
          user: user, hostelChangeStatus: hostelChangeStatus),
    );
  }
}
