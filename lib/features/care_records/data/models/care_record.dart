import 'package:isar/isar.dart';

import '../../../plants/datasource/models/plant.dart';

part 'care_record.g.dart';

enum Caretype{
  watering,
  pruning,
  fertilizing,
}

@collection
class CareRecord {
  
  Id careRecordId = Isar.autoIncrement;
  @enumerated
  late Caretype caretype;
  late DateTime careDate;
  String? note;

  final plant = IsarLink<Plant>();

  CareRecord({
    required this.caretype,
    required this.careDate,
    this.note
  });
}