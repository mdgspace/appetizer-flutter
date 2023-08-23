import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User{
  @JsonSerializable(fieldRename: FieldRename.snake)

  const factory User({
    required String email,
    required String hostelName,
    required String hostelCode,
    String? roomNo,
    required int enrNo,
    required String name,
    required String contactNo,
    String? branch,
    required dynamic imageUrl,
    required bool isCheckedOut,
    int? lastUpdated,
    int? leavesLeft,
    required dynamic dob,
    String? gender,
    required dynamic degree,
    required dynamic admissionYear,
    String? role,
    String? token,
    required bool isNew,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json); 
}
