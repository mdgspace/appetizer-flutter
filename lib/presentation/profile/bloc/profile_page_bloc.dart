import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserRepository repo;
  ProfilePageBloc({
    required this.repo,
  }) : super(const ProfilePageInitialState()) {
    on<ProfilePageFetchEvent>(_onFetch);
  }

  void _onFetch(
      ProfilePageFetchEvent event, Emitter<ProfilePageState> emit) async {
    // TODO: implement event handler
    User user = await repo.getCurrentUser();
    emit(
      ProfilePageFetchedState(
        user: user,
      ),
    );
  }
}
