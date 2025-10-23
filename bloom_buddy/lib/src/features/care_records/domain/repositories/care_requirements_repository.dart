import 'package:bloom_buddy/src/features/care_records/domain/entities/care_record.dart';

import '../entities/care_requirements.dart';

abstract class CareRequirementsRepository {
  Stream<List<CareRequirements>> watchCareRequirements(String plantId);
  Stream<List<CareRequirements>> watchCareRequirementsByStatus(
    String plantId,
    String status,
  );

  Stream<List<CareRecord>> watchCareRecords(String careId);

  Future<void> registerCareRecord(String careId);
  Future<CareRequirements> createCareRequirements(
    String plantId,
    String careType,
    int careFrequency, {
    String status = 'Scheduled',
    DateTime? lastCareDate,
    DateTime? nextCareDate,
  });
  Future<void> updateCareRequirements(CareRequirements careRequirements);
  Future<void> deleteCareRequirements(String careId);
}
