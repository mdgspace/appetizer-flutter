import 'package:freezed_annotation/freezed_annotation.dart';

part 'hostel_change_request.freezed.dart';
part 'hostel_change_request.g.dart';

@freezed
class HostelChangeRequest with _$HostelChangeRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory HostelChangeRequest(
      {required int user,
      required int id,
      required String hostelCode,
      required String newRoomNo,
      bool? isApprovedByAdmin,
      required String timestamp,
      required int newHostel}) = _HostelChangeRequest;

  factory HostelChangeRequest.fromJson(Map<String, dynamic> json) =>
      _$HostelChangeRequestFromJson(json);
}
