import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';
part 'coupon.g.dart';

@freezed
class Coupon with _$Coupon {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Coupon({
    required int id,
    required int mealId,
    required String mealType,
    required String mealDate,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}
