
// ignore_for_file: avoid_print

import 'dart:async';

import 'package:definitive_bloom_buddy/core/providers/isar_provider.dart';
import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:definitive_bloom_buddy/features/care_records/data/repository/care_data_source.dart';
import 'package:definitive_bloom_buddy/features/care_records/data/repository/care_data_source_impl.dart';
import 'package:definitive_bloom_buddy/features/care_records/domain/repository/care_repository.dart';
import 'package:definitive_bloom_buddy/features/care_records/domain/usecases/care_repository_impl.dart';
import 'package:definitive_bloom_buddy/features/care_records/presentation/state/care_countdown_provider.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/plant_provider.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../plants/datasource/models/plant.dart';

final careDataProvider = Provider<CareDataSource>((ref){
  final isar = ref.watch(isarProvider).value;
  return CareDataSourceImpl(isar!);
});

final careRepositoryProvider = Provider<CareRepository>((ref){
  final source = ref.watch(careDataProvider);
  return CareRepositoryImpl(source);
});

class CareRecordNotifer extends AsyncNotifier<List<CareRecord>> {
 
   Future<List<CareRecord>>_fetchCareRecords() async {
    final careRep = ref.watch(careRepositoryProvider);
    try {
      final fetchedCareRecords = await careRep.fetchAllCareRecords();
    for (final record in fetchedCareRecords) {
      await record.plant.load();
    }
      return fetchedCareRecords;
    } catch (e, stackTrace) {
      print('Error fetching care records in Notifer ; $e\n$stackTrace');
      throw Exception('Error : $e');
    }
  }
  

   @override
  FutureOr<List<CareRecord>> build() async{
    try {
      final plants = await _fetchCareRecords();
      return plants;
    } catch (error) {
      print('Error loading plant in Notifer ; $error');
      rethrow;
    }
  }

   Future<void> deletePlant(int id) async {
    final careRep = ref.read(careRepositoryProvider);
    try {
      await careRep.deleteCareRecord(id);
      ref.invalidateSelf();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addCareRecord (WidgetRef ref, Plant plant, CareRecord careRecord) async{
    final careRep = ref.read(careRepositoryProvider);
    try {
      await careRep.saveCareRecord(plant, careRecord);
      ref.read(careCountdownProvider(plant.plantId).notifier).careWasPerfomed(careRecord.caretype);
      ref.invalidate(plantNotifierProvider);

      if (ref.read(plantFilterProvider.notifier).state == PlantFilter.urgent) {
        ref.read(plantNotifierProvider.notifier).refreshData();
      }
      
      print('plante mise a jour pour ce nouveau soin');
    } catch (e) {
      print('Erreur lors de l\'enregistrement des soins ou de la reinitialisation du compteur $e');
    }
  }

  Future<void> updateCareRecord(CareRecord careRecord) async {
    final careRep = ref.read(careRepositoryProvider);
    try {
      await careRep.updateCareRecord(careRecord);
    } catch (e) {
      print(e);
    }
  }
}

final careRecordNotiferProvider = AsyncNotifierProvider<CareRecordNotifer, List<CareRecord>>((){
  return CareRecordNotifer();
});