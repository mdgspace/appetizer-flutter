part of 'no_internet_bloc.dart';

class NoInternetEvent extends Equatable {
  const NoInternetEvent();

  @override
  List<Object?> get props => [];
}

class ReloadPressed extends NoInternetEvent {
  const ReloadPressed();
}
