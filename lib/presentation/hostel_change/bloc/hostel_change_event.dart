part of 'hostel_change_bloc.dart';

abstract class HostelChangeEvent {}

class HostelChangePressed extends HostelChangeEvent {
  final String hostel;
  final String roomNo;
  HostelChangePressed({
    required this.hostel,
    required this.roomNo,
  });
}

class HostelSearchQueryChanged extends HostelChangeEvent {
  final String query;
  HostelSearchQueryChanged({
    required this.query,
  });
}
