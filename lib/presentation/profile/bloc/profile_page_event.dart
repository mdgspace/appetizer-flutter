part of 'profile_page_bloc.dart';

abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfile extends ProfilePageEvent {
  const FetchProfile();

  @override
  List<Object?> get props => [];
}
