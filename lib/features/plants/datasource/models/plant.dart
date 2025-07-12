import 'package:isar/isar.dart';

import '../../../care_records/data/models/care_record.dart';

part 'plant.g.dart';



@embedded
class CareRequirements {
  int? wateringFrequencyDays;
  int? fertilizingFrequencyWeeks;
  int? pruningFrequencyMonth;
 

  CareRequirements({
    this.wateringFrequencyDays,
    this.fertilizingFrequencyWeeks,
    this.pruningFrequencyMonth,
  });

  bool get isWatering {
    if (wateringFrequencyDays != null) {
      return true;
    }else{
      return false;
    }
  }
  bool get isFertilizing {
    if (fertilizingFrequencyWeeks != null) {
      return true;
    }else{
      return false;
    }
  }
  bool get isPruning {
    if (pruningFrequencyMonth != null) {
      return true;
    }else{
      return false;
    }
  }
}

@collection
class Plant {
  
  Id plantId = Isar.autoIncrement;

  String plantName;
  String plantSpecie;
  String? plantDescription;
   bool isFavorite;
  DateTime createdAt;

  CareRequirements requirements;

  @Backlink(to: 'plant')
  final careHistory = IsarLinks<CareRecord>();

Plant({
  required this.plantName,
  required this.plantSpecie,
  this.plantDescription,
  required this.requirements
}): createdAt = DateTime.now(), isFavorite = false;

  bool changedFavorite(){
   isFavorite = !isFavorite;
   return isFavorite;
  }
}
