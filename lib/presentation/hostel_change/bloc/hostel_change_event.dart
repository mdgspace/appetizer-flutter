part of 'hostel_change_bloc.dart';

abstract class HostelChangeEvent {}

class HostelChangePressed extends HostelChangeEvent {
  final String hostel;
  HostelChangePressed({
    required this.hostel,
  });
}

class HostelSearchQueryChanged extends HostelChangeEvent {
  final String query;
  HostelSearchQueryChanged({
    required this.query,
  });
}
