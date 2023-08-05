import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'coupons_page_event.dart';
part 'coupons_page_state.dart';

class CouponsPageBloc extends Bloc<CouponsPageEvent, CouponsPageState> {
  CouponsPageBloc() : super(CouponsPageInitial()) {
    on<CouponsPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
