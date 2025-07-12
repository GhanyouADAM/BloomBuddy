
// ignore_for_file: avoid_print

import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';

import 'package:definitive_bloom_buddy/features/care_records/domain/repository/care_repository.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';

import '../../data/repository/care_data_source.dart';

class CareRepositoryImpl implements CareRepository {
  final CareDataSource _careSource;
  CareRepositoryImpl(this._careSource);

  @override
  Future<void> deleteCareRecord(int careId) async{
    try {
      await _careSource.deleteCareRecord(careId);
    } catch (e) {
      print('Error from repository while deleting plant : $e');
      rethrow;
    }
  }

  @override
  Future<List<CareRecord>> fetchAllCareRecords() async{
   try {
     return await _careSource.getAllCareRecord();
   } catch (e) {
     print("Error from repository while fetching all care records from database : $e");
     rethrow;
   }
  }

  @override
  Future<void> saveCareRecord(Plant plant, CareRecord careRecord) async {
    try {
      await _careSource.addCareRecord(careRecord, plant);
    } catch (e) {
      print("Error from repository while adding care records $e");
      rethrow;
    }
  }

  @override
  Future<void> updateCareRecord(CareRecord careRecord) async {
    try {
      await _careSource.updateCareRecord(careRecord);
    } catch (e) {
      print('Error from repository while updating : $e');
      rethrow;
    }
  }
  
}