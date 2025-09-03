// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'care_requirements.dart';

class CareRequirementsMapper extends ClassMapperBase<CareRequirements> {
  CareRequirementsMapper._();

  static CareRequirementsMapper? _instance;
  static CareRequirementsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CareRequirementsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CareRequirements';

  static String _$careId(CareRequirements v) => v.careId;
  static const Field<CareRequirements, String> _f$careId =
      Field('careId', _$careId, key: r'care_id');
  static String _$plantId(CareRequirements v) => v.plantId;
  static const Field<CareRequirements, String> _f$plantId =
      Field('plantId', _$plantId, key: r'plant_id');
  static String _$careType(CareRequirements v) => v.careType;
  static const Field<CareRequirements, String> _f$careType =
      Field('careType', _$careType, key: r'care_type');
  static int _$careFrequency(CareRequirements v) => v.careFrequency;
  static const Field<CareRequirements, int> _f$careFrequency =
      Field('careFrequency', _$careFrequency, key: r'care_frequency');
  static DateTime? _$createdAt(CareRequirements v) => v.createdAt;
  static const Field<CareRequirements, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at');
  static DateTime? _$updatedAt(CareRequirements v) => v.updatedAt;
  static const Field<CareRequirements, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, key: r'updated_at');

  @override
  final MappableFields<CareRequirements> fields = const {
    #careId: _f$careId,
    #plantId: _f$plantId,
    #careType: _f$careType,
    #careFrequency: _f$careFrequency,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static CareRequirements _instantiate(DecodingData data) {
    return CareRequirements(
        careId: data.dec(_f$careId),
        plantId: data.dec(_f$plantId),
        careType: data.dec(_f$careType),
        careFrequency: data.dec(_f$careFrequency),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static CareRequirements fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CareRequirements>(map);
  }

  static CareRequirements fromJson(String json) {
    return ensureInitialized().decodeJson<CareRequirements>(json);
  }
}

mixin CareRequirementsMappable {
  String toJson() {
    return CareRequirementsMapper.ensureInitialized()
        .encodeJson<CareRequirements>(this as CareRequirements);
  }

  Map<String, dynamic> toMap() {
    return CareRequirementsMapper.ensureInitialized()
        .encodeMap<CareRequirements>(this as CareRequirements);
  }

  CareRequirementsCopyWith<CareRequirements, CareRequirements, CareRequirements>
      get copyWith =>
          _CareRequirementsCopyWithImpl<CareRequirements, CareRequirements>(
              this as CareRequirements, $identity, $identity);
  @override
  String toString() {
    return CareRequirementsMapper.ensureInitialized()
        .stringifyValue(this as CareRequirements);
  }

  @override
  bool operator ==(Object other) {
    return CareRequirementsMapper.ensureInitialized()
        .equalsValue(this as CareRequirements, other);
  }

  @override
  int get hashCode {
    return CareRequirementsMapper.ensureInitialized()
        .hashValue(this as CareRequirements);
  }
}

extension CareRequirementsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CareRequirements, $Out> {
  CareRequirementsCopyWith<$R, CareRequirements, $Out>
      get $asCareRequirements => $base
          .as((v, t, t2) => _CareRequirementsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CareRequirementsCopyWith<$R, $In extends CareRequirements, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? careId,
      String? plantId,
      String? careType,
      int? careFrequency,
      DateTime? createdAt,
      DateTime? updatedAt});
  CareRequirementsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CareRequirementsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CareRequirements, $Out>
    implements CareRequirementsCopyWith<$R, CareRequirements, $Out> {
  _CareRequirementsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CareRequirements> $mapper =
      CareRequirementsMapper.ensureInitialized();
  @override
  $R call(
          {String? careId,
          String? plantId,
          String? careType,
          int? careFrequency,
          Object? createdAt = $none,
          Object? updatedAt = $none}) =>
      $apply(FieldCopyWithData({
        if (careId != null) #careId: careId,
        if (plantId != null) #plantId: plantId,
        if (careType != null) #careType: careType,
        if (careFrequency != null) #careFrequency: careFrequency,
        if (createdAt != $none) #createdAt: createdAt,
        if (updatedAt != $none) #updatedAt: updatedAt
      }));
  @override
  CareRequirements $make(CopyWithData data) => CareRequirements(
      careId: data.get(#careId, or: $value.careId),
      plantId: data.get(#plantId, or: $value.plantId),
      careType: data.get(#careType, or: $value.careType),
      careFrequency: data.get(#careFrequency, or: $value.careFrequency),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  CareRequirementsCopyWith<$R2, CareRequirements, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CareRequirementsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
