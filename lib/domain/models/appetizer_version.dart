import 'package:json_annotation/json_annotation.dart';

part 'appetizer_version.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppetizerVersion {
  String number;
  String platform;
  dynamic expiryDate;
  bool isExpired;
  bool isLatest;
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
