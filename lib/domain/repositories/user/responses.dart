part of 'user_repository.dart';

@JsonSerializable()
class UserStatusResponse {
  final String status;

  UserStatusResponse({required this.status});

  factory UserStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$UserStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatusResponseToJson(this);
}
