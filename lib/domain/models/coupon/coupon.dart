import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';
part 'coupon.g.dart';

@freezed
class Coupon with _$Coupon {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Coupon({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'meal') required String meal,
    @JsonKey(name: 'is_active') bool? isActive,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}