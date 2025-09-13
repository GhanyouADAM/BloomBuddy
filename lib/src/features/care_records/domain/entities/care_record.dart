import 'package:dart_mappable/dart_mappable.dart';

part 'care_record.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CareRecord with CareRecordMappable {
  final String recordId;
  final String careRequirementId;
  final DateTime createdAt;

  CareRecord({
    required this.recordId,
    required this.careRequirementId,
    required this.createdAt,
  });
}
