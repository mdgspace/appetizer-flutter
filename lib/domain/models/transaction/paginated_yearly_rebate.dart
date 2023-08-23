import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_yearly_rebate.freezed.dart';
part 'paginated_yearly_rebate.g.dart';

@freezed
class PaginatedYearlyRebate with _$PaginatedYearlyRebate {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  
  const factory PaginatedYearlyRebate({
    required int count,
    required bool hasNext,
    required bool hasPrevious,
    required List<YearlyRebate> results,
  }) = _PaginatedYearlyRebate;

  factory PaginatedYearlyRebate.fromJson(Map<String, dynamic> json) =>
      _$PaginatedYearlyRebateFromJson(json);
}

@freezed
class YearlyRebate with _$YearlyRebate {
  @JsonSerializable(fieldRename: FieldRename.snake)

  const factory YearlyRebate({
    required int monthId,
    required int year,
    required dynamic bill,
    required int expenses,
    required num rebate,
    required int startDate,
  }) = _YearlyRebate;

  factory YearlyRebate.fromJson(Map<String, dynamic> json) =>
      _$YearlyRebateFromJson(json);
}
