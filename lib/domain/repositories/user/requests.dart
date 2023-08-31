part of 'user_repository.dart';

@JsonSerializable()
class UserStatusRequest {
  @JsonKey(name: 'enr')
  final int enrollment;

  UserStatusRequest({required this.enrollment});

  factory UserStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$UserStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatusRequestToJson(this);
}
