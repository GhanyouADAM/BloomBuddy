
// ignore_for_file: avoid_print

import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:definitive_bloom_buddy/features/care_records/data/repository/care_data_source.dart';
import 'package:isar/isar.dart';

import '../../../plants/datasource/models/plant.dart';

class CareDataSourceImpl implements CareDataSource {
  final Isar isar;
  CareDataSourceImpl(this.isar);

  @override
  Future<void> addCareRecord(CareRecord careRecord, Plant plant) async {
   await isar.writeTxn(() async{
    await isar.careRecords.put(careRecord);
       careRecord.plant.value = plant;
          await careRecord.plant.save();
   });
  

  }

  @override
  Future<void> deleteCareRecord(int careId) async{
    await isar.writeTxn(() => isar.careRecords.delete(careId));
  }

  @override
  Future<List<CareRecord>> getAllCareRecord() async{
    final careRecords = await isar.writeTxn(()=> isar.careRecords.where().findAll());
    for (final care in careRecords) {
      await care.plant.load();
    }
    if (careRecords.isNotEmpty) {
      print('Found ${careRecords.length} cares records');
      return careRecords;
    }else{
      print('No care records found in database');
      return [];
    }
  }

  @override
  Future<void> updateCareRecord(CareRecord careRecord) async{
    await isar.writeTxn(() => isar.careRecords.put(careRecord));
  }
  
}