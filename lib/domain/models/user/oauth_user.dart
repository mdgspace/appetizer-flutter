import 'package:appetizer/domain/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oauth_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class OAuthUser {
  String? token;
  User studentData;
  bool isNew;

  OAuthUser({
    this.token,
    required this.studentData,
    required this.isNew,
  });

  factory OAuthUser.fromJson(Map<String, dynamic> json) =>
      _$OAuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthUserToJson(this);
}
