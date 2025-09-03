// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'plant.dart';

class PlantMapper extends ClassMapperBase<Plant> {
  PlantMapper._();

  static PlantMapper? _instance;
  static PlantMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlantMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Plant';

  static String _$userId(Plant v) => v.userId;
  static const Field<Plant, String> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static String _$plantId(Plant v) => v.plantId;
  static const Field<Plant, String> _f$plantId =
      Field('plantId', _$plantId, key: r'plant_id');
  static String _$plantName(Plant v) => v.plantName;
  static const Field<Plant, String> _f$plantName =
      Field('plantName', _$plantName, key: r'plant_name');
  static String _$plantSpecie(Plant v) => v.plantSpecie;
  static const Field<Plant, String> _f$plantSpecie =
      Field('plantSpecie', _$plantSpecie, key: r'plant_specie');
  static String? _$plantDescription(Plant v) => v.plantDescription;
  static const Field<Plant, String> _f$plantDescription =
      Field('plantDescription', _$plantDescription, key: r'plant_description');
  static bool _$isLiked(Plant v) => v.isLiked;
  static const Field<Plant, bool> _f$isLiked =
      Field('isLiked', _$isLiked, key: r'is_liked', opt: true, def: false);
  static DateTime _$createdAt(Plant v) => v.createdAt;
  static const Field<Plant, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at');
  static DateTime _$updatedAt(Plant v) => v.updatedAt;
  static const Field<Plant, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, key: r'updated_at');

  @override
  final MappableFields<Plant> fields = const {
    #userId: _f$userId,
    #plantId: _f$plantId,
    #plantName: _f$plantName,
    #plantSpecie: _f$plantSpecie,
    #plantDescription: _f$plantDescription,
    #isLiked: _f$isLiked,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static Plant _instantiate(DecodingData data) {
    return Plant(
        userId: data.dec(_f$userId),
        plantId: data.dec(_f$plantId),
        plantName: data.dec(_f$plantName),
        plantSpecie: data.dec(_f$plantSpecie),
        plantDescription: data.dec(_f$plantDescription),
        isLiked: data.dec(_f$isLiked),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static Plant fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Plant>(map);
  }

  static Plant fromJson(String json) {
    return ensureInitialized().decodeJson<Plant>(json);
  }
}

mixin PlantMappable {
  String toJson() {
    return PlantMapper.ensureInitialized().encodeJson<Plant>(this as Plant);
  }

  Map<String, dynamic> toMap() {
    return PlantMapper.ensureInitialized().encodeMap<Plant>(this as Plant);
  }

  PlantCopyWith<Plant, Plant, Plant> get copyWith =>
      _PlantCopyWithImpl<Plant, Plant>(this as Plant, $identity, $identity);
  @override
  String toString() {
    return PlantMapper.ensureInitialized().stringifyValue(this as Plant);
  }

  @override
  bool operator ==(Object other) {
    return PlantMapper.ensureInitialized().equalsValue(this as Plant, other);
  }

  @override
  int get hashCode {
    return PlantMapper.ensureInitialized().hashValue(this as Plant);
  }
}

extension PlantValueCopy<$R, $Out> on ObjectCopyWith<$R, Plant, $Out> {
  PlantCopyWith<$R, Plant, $Out> get $asPlant =>
      $base.as((v, t, t2) => _PlantCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlantCopyWith<$R, $In extends Plant, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? userId,
      String? plantId,
      String? plantName,
      String? plantSpecie,
      String? plantDescription,
      bool? isLiked,
      DateTime? createdAt,
      DateTime? updatedAt});
  PlantCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlantCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Plant, $Out>
    implements PlantCopyWith<$R, Plant, $Out> {
  _PlantCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Plant> $mapper = PlantMapper.ensureInitialized();
  @override
  $R call(
          {String? userId,
          String? plantId,
          String? plantName,
          String? plantSpecie,
          Object? plantDescription = $none,
          bool? isLiked,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      $apply(FieldCopyWithData({
        if (userId != null) #userId: userId,
        if (plantId != null) #plantId: plantId,
        if (plantName != null) #plantName: plantName,
        if (plantSpecie != null) #plantSpecie: plantSpecie,
        if (plantDescription != $none) #plantDescription: plantDescription,
        if (isLiked != null) #isLiked: isLiked,
        if (createdAt != null) #createdAt: createdAt,
        if (updatedAt != null) #updatedAt: updatedAt
      }));
  @override
  Plant $make(CopyWithData data) => Plant(
      userId: data.get(#userId, or: $value.userId),
      plantId: data.get(#plantId, or: $value.plantId),
      plantName: data.get(#plantName, or: $value.plantName),
      plantSpecie: data.get(#plantSpecie, or: $value.plantSpecie),
      plantDescription:
          data.get(#plantDescription, or: $value.plantDescription),
      isLiked: data.get(#isLiked, or: $value.isLiked),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  PlantCopyWith<$R2, Plant, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlantCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
