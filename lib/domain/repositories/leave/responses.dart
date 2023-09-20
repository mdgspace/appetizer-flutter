part of 'leave_repository.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckoutResponse {
  int? checkoutTime, checkinTime, user;
  bool isCheckedOut;

  CheckoutResponse({
    required this.isCheckedOut,
    this.checkinTime,
    this.checkoutTime,
    this.user,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
