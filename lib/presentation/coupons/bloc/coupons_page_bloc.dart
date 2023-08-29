import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'coupons_page_event.dart';
part 'coupons_page_state.dart';

class CouponsPageBloc extends Bloc<CouponsPageEvent, CouponsPageState> {
  final CouponRepository repo;
  CouponsPageBloc({
    required this.repo,
  }) : super(const CouponsPageInitialState()) {
    on<CouponsPageFetchEvent>(_onCouponFetch);
  }

  void _onCouponFetch(
      CouponsPageFetchEvent event, Emitter<CouponsPageState> emit) async {
    List<Coupon> coupons = [];
    try {
      coupons = await repo.getAllCoupon();
      emit(
        CouponsPageFetchedState(coupons: coupons),
      );
    } catch (e) {
      emit(
        CouponsPageFailedState(coupons: coupons),
      );
    }
  }
}
