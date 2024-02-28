part of 'no_internet_bloc.dart';

class NoInternetState extends Equatable {
  const NoInternetState();

  @override
  List<Object> get props => [];
}

class NoInternetInitial extends NoInternetState {
  const NoInternetInitial();
}

class Loading extends NoInternetState {
  const Loading();
}

class ReloadSuccess extends NoInternetState {
  const ReloadSuccess();
}
