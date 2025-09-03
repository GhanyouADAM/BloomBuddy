import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PlantFilter { date, name, category }

final plantFilterIndexProvider = StateProvider<int>((ref) => 0);
final plantFilterProvider = Provider<PlantFilter>((ref) {
  final selectedIndex = ref.watch(plantFilterIndexProvider);
  switch (selectedIndex) {
    case 0:
      return PlantFilter.date;
    case 1:
      return PlantFilter.name;
    case 2:
      return PlantFilter.category;
    default:
      return PlantFilter.date;
  }
});
