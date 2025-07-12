import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';

abstract class CareRepository {
  
  Future<List<CareRecord>> fetchAllCareRecords();
  Future<void> saveCareRecord(Plant plant, CareRecord careRecord);
  Future<void> updateCareRecord(CareRecord careRecord);
  Future<void> deleteCareRecord(int careId);
}