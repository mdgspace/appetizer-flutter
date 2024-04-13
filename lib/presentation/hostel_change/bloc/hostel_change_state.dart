part of 'hostel_change_bloc.dart';

abstract class HostelChangeState extends Equatable {
  const HostelChangeState();

  @override
  List<Object?> get props => [];
}

class HostelChangeInitial extends HostelChangeState {
  final String? error;
  const HostelChangeInitial({this.error});
}

class Loading extends HostelChangeState {}

class HostelChangeSuccess extends HostelChangeState {}

class HostelQueryChanged extends HostelChangeState {
  final String query;
  const HostelQueryChanged({required this.query});
}
