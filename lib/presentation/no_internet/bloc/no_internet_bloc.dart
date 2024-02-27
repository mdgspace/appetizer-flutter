import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'no_internet_event.dart';
part 'no_internet_state.dart';

class NoInternetBloc extends Bloc<NoInternetEvent, NoInternetState> {
  final UserRepository repo;
  NoInternetBloc({required this.repo}) : super(const NoInternetState()) {
    on<ReloadPressed>(_onReloadPressed);
  }

  void _onReloadPressed(
      ReloadPressed event, Emitter<NoInternetState> emit) async {
    try {
      User user = await repo.getCurrentUser();

    } catch (e) {}
  }
}
