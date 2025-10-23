import 'package:dart_mappable/dart_mappable.dart';

part 'care_requirements.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CareRequirements with CareRequirementsMappable {
  String careId;
  String plantId;
  String careType;
  int careFrequency;
  String status;
  DateTime? lastCareDate;
  DateTime? nextCareDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  CareRequirements({
    required this.careId,
    required this.plantId,
    required this.careType,
    required this.careFrequency,
    required this.status,
    required this.lastCareDate,
    required this.nextCareDate,
    required this.createdAt,
    required this.updatedAt,
  });
}
