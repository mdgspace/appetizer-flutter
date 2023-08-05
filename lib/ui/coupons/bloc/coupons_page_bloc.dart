import 'package:appetizer_revamp_parts/models/coupon/coupon.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'coupons_page_event.dart';
part 'coupons_page_state.dart';

class CouponsPageBloc extends Bloc<CouponsPageEvent, CouponsPageState> {
  CouponsPageBloc() : super(const CouponsPageInitialState()) {
    on<CouponsPageFetchEvent>(
        (CouponsPageFetchEvent event, Emitter<CouponsPageState> emit) {
      // TODO: implement repository call
      bool submissionSuccessful = true;
      List<Coupon> coupons = [];
      if (submissionSuccessful) {
        emit(
          CouponsPageFetchedState(
            coupons: coupons,
          ),
        );
      } else {
        emit(
          CouponsPageFailedState(
            coupons: event.coupons,
          ),
        );
      }
    });
  }
}
