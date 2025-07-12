
// ignore_for_file: avoid_print

import 'dart:async';

import 'package:definitive_bloom_buddy/core/providers/isar_provider.dart';
import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

typedef CareCountdownState = Map<Caretype, int?>;

class CareCountdownNotifier extends FamilyAsyncNotifier<CareCountdownState, int>{
   Isar? _isar;

   //Methode principale appelée lors de la création/mise à jour
  @override
  FutureOr<CareCountdownState> build(int plantId) async {
    _isar = await ref.watch(isarProvider.future);
    ref.keepAlive(); // permet de garder l'etat même si plus aucun widget ne l'écoute

    return await _calculateAllDaysRemaining(plantId);
  }

//Methode privée pour calculer les jours restants pour tout les types de soin
  Future<CareCountdownState> _calculateAllDaysRemaining (int plantId) async {
    if(_isar == null) throw Exception('isar not initialized yet');

    final plant = await _isar!.plants.get(plantId);
    if (plant == null) {
      print('plant with ID : $plantId was not found for countdown calculation');
      return {};
    }
    final Map<Caretype, int?> daysRemainingMap = {};
    for(final careType in Caretype.values){
      daysRemainingMap[careType] = await _calculateDaysRemainingForType(plant,careType); 
    }

    return daysRemainingMap;
  }

//Methode privée pour calculer les jours restants pour Un type de soin spécifique
  Future<int?> _calculateDaysRemainingForType(Plant plant, Caretype caretype) async {
    if(_isar == null) return null;

    int? frequencyInDays;
    switch (caretype) {
      case Caretype.watering:
        frequencyInDays = plant.requirements.wateringFrequencyDays;
      case Caretype.fertilizing :
      frequencyInDays = plant.requirements.fertilizingFrequencyWeeks != null ? plant.requirements.fertilizingFrequencyWeeks! * 7 : null;
      case Caretype.pruning:
      frequencyInDays = plant.requirements.pruningFrequencyMonth != null ? plant.requirements.pruningFrequencyMonth! * 30 : null;
        break;
    }
   if (frequencyInDays == null || frequencyInDays<= 0) {
     return null;
   }

   final lastCareRecord = await _isar!.careRecords
                                                                  .filter()
                                                                  .plant((q)=> q.plantIdEqualTo(plant.plantId)) // Filtre par l'ID de la plante liée
                                                                  .caretypeEqualTo(caretype)
                                                                  .sortByCareDateDesc()
                                                                  .findFirst();

    final now = DateTime.now();
    //on normalise now a miniuit pour comparer les jours entiers
    final today = DateTime(now.day, now.month, now.year);

    if (lastCareRecord == null) {
      print("Ancun enregistrement de soin trouvé pour ${plant.plantName} - ${caretype.name}, proceder donc au prochain enregistrement");
      return 0;
    }else{
      final lastCareRecordDate = DateTime(lastCareRecord.careDate.day, lastCareRecord.careDate.month, lastCareRecord.careDate.year);
      final nextDueDate = lastCareRecordDate.add(Duration(days: frequencyInDays));
      final difference = nextDueDate.difference(today).inDays;

      //si la difference est négative alors le soin est en retard alors on retourne 0
      return difference < 0 ? 0 :  difference;
    }
  }

///Methode appelé MANUELLEMENT après avoir enregistré un nouveau soin
///Elle recalcule immédiatement le nombre de jours restant pour le type de soin éffectué
Future<void> careWasPerfomed(Caretype caretypePerfomed) async{

  //l'état étant asyncValue on s'assure qu'on bien des valeurs avant de continuer
  if(!state.hasValue || state.value == null) return;

  final plantId = arg; //récupère l'id de la plante passée au .family(build)
  if (_isar == null) {
    print('Isar n\'est pas encore pret pour le relancement du decompte du soin : ${caretypePerfomed.name}');
    return;
  }
  final plant = await _isar!.plants.get(plantId);
  if (plant == null) {
    print("pas de plante trouvée pour cet ID : $plantId");
  return;
  }

  //recalcule spécifiquement pour le soin qui vient d'être éffectué
  //Normalement, après un soin, le compteur repart à la frequence définie
  int? frequencyInDays;
    switch (caretypePerfomed) {
      case Caretype.watering:
        frequencyInDays = plant.requirements.wateringFrequencyDays;
      case Caretype.fertilizing :
      frequencyInDays = plant.requirements.fertilizingFrequencyWeeks != null ? plant.requirements.fertilizingFrequencyWeeks! * 7 : null;
      case Caretype.pruning:
      frequencyInDays = plant.requirements.pruningFrequencyMonth != null ? plant.requirements.pruningFrequencyMonth! * 30 : null;
        break;
    }
   if (frequencyInDays == null || frequencyInDays<= 0) {
     print("la frequence non définie pour ce soin, le compteur ne se reinitialise pas");
     // Pour forcer une recalculation complète si nécessaire
       // state = AsyncData(await _calculateAllDaysRemaining(plantId));
       return;
   }

   //Met a jour l'état avec la nouvelle valeur pour ce type de soin
  final currentState = state.value!;
  final newState = Map<Caretype, int?>.from(currentState); //créé une copie de l'état actuel pour modification
  newState[caretypePerfomed] = frequencyInDays; // reinitialise au nombre de jours de la frequence

  state =AsyncData(newState); //Met a jour l'état du provider
  print("Compteur de soin reinitialiser pour ${plant.plantName} - ${caretypePerfomed.name} à $frequencyInDays jours.");
}

///Methode pour rafraîchir MANUELLEMENT tous les compteurs
Future<void> refreshAllCounters() async {
  final plantId =  arg;
  print("rafraîchissement des compteurs pour la plante $plantId");
  state = const AsyncLoading(); // Indique l'état de chargement
  try {
    final newState = await _calculateAllDaysRemaining(plantId);
    state =AsyncData(newState);
  } catch (e, stack) {
    state = AsyncError(e, stack);
    print("Error durant le rafraîchissement des coumpteurs");
  }
}
}

//Le provider lui-même utilise .family pour passer l'id de la plante
final careCountdownProvider = AsyncNotifierProvider.family<CareCountdownNotifier, CareCountdownState, int>(() => CareCountdownNotifier());