import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../features/plants/datasource/models/plant.dart';

class IsarHelper {

Future<Isar> openIsarInstance() async{
  final dir = await getApplicationDocumentsDirectory();
  if (Isar.instanceNames.isEmpty) {
    return await Isar.open(
      [PlantSchema, CareRecordSchema],
       directory: dir.path,
       inspector: true
       );
  }
  return Future.value(Isar.getInstance());

  //verification si une instance est potentiellement déjà ouverte
}
}

//dead class, utilisation du provider a la place mais je garde quand meme