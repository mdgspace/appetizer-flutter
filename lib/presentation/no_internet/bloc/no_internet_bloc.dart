import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'no_internet_event.dart';
part 'no_internet_state.dart';

class NoInternetBloc extends Bloc<NoInternetEvent, NoInternetState> {
  final UserRepository repo;
  NoInternetBloc({required this.repo}) : super(const NoInternetInitial()) {
    on<ReloadPressed>(_onReloadPressed);
  }

  void _onReloadPressed(
      ReloadPressed event, Emitter<NoInternetState> emit) async {
    emit(const Loading());
    try {
      await repo.getCurrentUser();
      emit(const ReloadSuccess());
    } catch (e) {
      emit(const NoInternetInitial());
    }
  }
}
