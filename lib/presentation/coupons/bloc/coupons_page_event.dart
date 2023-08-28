part of 'coupons_page_bloc.dart';

abstract class CouponsPageEvent extends Equatable {
  const CouponsPageEvent();

  @override
  List<Object> get props => [];
}

class CouponsPageFetchEvent extends CouponsPageEvent {
  const CouponsPageFetchEvent({
    required this.coupons,
    required this.user,
  });

  final List<Coupon> coupons;
  final User user;

  @override
  List<Object> get props => [coupons, user];
}
