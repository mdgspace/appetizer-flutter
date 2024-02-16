part of 'profile_page_bloc.dart';

class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

class ProfilePageInitialState extends ProfilePageState {
  const ProfilePageInitialState();

  @override
  List<Object> get props => [];
}

class ProfilePageFetchedState extends ProfilePageState {
  const ProfilePageFetchedState({
    required this.hostelChangeStatus,
    required this.user,
  });

  final User user;
  final dynamic hostelChangeStatus;

  @override
  List<Object> get props => [user, hostelChangeStatus];
}
