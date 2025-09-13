import 'package:dart_mappable/dart_mappable.dart';

part 'plant.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class Plant with PlantMappable {
  String userId;
  String plantId;
  String plantName;
  String plantSpecie;
  String? plantDescription;
  bool isLiked;
  DateTime createdAt;
  DateTime updatedAt;

  Plant({
    required this.userId,
    required this.plantId,
    required this.plantName,
    required this.plantSpecie,
    required this.plantDescription,
    this.isLiked = false,
    required this.createdAt,
    required this.updatedAt,
  });
}
