import 'package:appetizer/domain/models/leaves/leave.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_leaves.freezed.dart';
part 'paginated_leaves.g.dart';

@freezed
class PaginatedLeaves with _$PaginatedLeaves {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaginatedLeaves({
    required int count,
    @JsonKey(name: 'has_next') 
    required bool hasNext,
    @JsonKey(name: 'has_previous')
    required bool hasPrevious,
    required List<Leave> results,
  }) = _PaginatedLeaves;

  // TODO: check if leaves parse correctly into the map

  factory PaginatedLeaves.fromJson(Map<String, dynamic> json) => _$PaginatedLeavesFromJson(json);
}