import 'package:json_annotation/json_annotation.dart';

part 'appetizer_version.g.dart';

@JsonSerializable()
class AppetizerVersion {
  String number;
  String platform;
  @JsonKey(name: "expiry_date")
  dynamic expiryDate;
  @JsonKey(name: "is_expired")
  bool isExpired;
  @JsonKey(name: "is_latest")
  bool isLatest;
  @JsonKey(name: "date_created")
  int dateCreated;

  AppetizerVersion({
    required this.number,
    required this.platform,
    required this.expiryDate,
    required this.isExpired,
    required this.isLatest,
    required this.dateCreated,
  });

  factory AppetizerVersion.fromJson(Map<String, dynamic> json) =>
      _$AppetizerVersionFromJson(json);

  Map<String, dynamic> toJson() => _$AppetizerVersionToJson(this);
}
