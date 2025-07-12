
import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';

import '../../../plants/datasource/models/plant.dart';

abstract class CareDataSource {
  
  Future<List<CareRecord>> getAllCareRecord();
  Future<void> addCareRecord(CareRecord careRecord, Plant plant);
  Future<void> updateCareRecord(CareRecord careRecord);
  Future<void> deleteCareRecord(int careId);
}