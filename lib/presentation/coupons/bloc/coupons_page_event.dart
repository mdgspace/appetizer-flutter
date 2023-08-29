part of 'coupons_page_bloc.dart';

abstract class CouponsPageEvent extends Equatable {
  const CouponsPageEvent();

  @override
  List<Object> get props => [];
}

class CouponsPageFetchEvent extends CouponsPageEvent {
  const CouponsPageFetchEvent();
}
