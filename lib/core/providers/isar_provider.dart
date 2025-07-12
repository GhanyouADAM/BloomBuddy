
import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final isarProvider = FutureProvider<Isar>((ref) async{
  final dir = await getApplicationDocumentsDirectory();
  if (Isar.instanceNames.isEmpty) {
    return await Isar.open(
      [PlantSchema, CareRecordSchema],
      directory: dir.path,
      inspector: true
     );
  }
  return Isar.getInstance()!;
});