import 'package:definitive_bloom_buddy/core/utils/first_run.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PlantFilter{
  plants,
  favorites,
  urgent,
}

final searchQueryProvider = StateProvider<String>((ref)=> '');
final isFirstRunProvider = FutureProvider<bool>((ref) async {
  return FirstRunChecker.isFirstRun();
});
final plantFilterProvider = StateProvider<PlantFilter>((ref){
  return PlantFilter.plants;
});
final wateringSliderProvider = StateProvider<double> ((ref) => 0.0);
final pruningSliderProvider = StateProvider<double> ((ref) => 0.0);
final fertilizingSliderProvider = StateProvider<double> ((ref) => 0.0);

final isWateringProvider = StateProvider<bool>((ref) => false,);
final isFertilizingProvider = StateProvider<bool>((ref) => false,);
final isPruningProvider = StateProvider<bool>((ref) => false,);


final indexProvider = StateProvider<int>((ref)=> 0);