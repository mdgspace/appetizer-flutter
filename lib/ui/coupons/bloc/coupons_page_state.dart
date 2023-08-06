part of 'coupons_page_bloc.dart';

abstract class CouponsPageState extends Equatable {
  const CouponsPageState();

  @override
  List<Object> get props => [];
}

class CouponsPageInitialState extends CouponsPageState {
  const CouponsPageInitialState();

  @override
  List<Object> get props => [];
}

class CouponsPageFetchedState extends CouponsPageState {
  const CouponsPageFetchedState({
    required this.coupons,
  });

  final List<Coupon> coupons;

  @override
  List<Object> get props => [coupons];
}

class CouponsPageFailedState extends CouponsPageState {
  const CouponsPageFailedState({
    required this.coupons,
  });

  final List<Coupon> coupons;

  @override
  List<Object> get props => [coupons];
}
