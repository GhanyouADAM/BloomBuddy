// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'care_record.dart';

class CareRecordMapper extends ClassMapperBase<CareRecord> {
  CareRecordMapper._();

  static CareRecordMapper? _instance;
  static CareRecordMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CareRecordMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CareRecord';

  static String _$recordId(CareRecord v) => v.recordId;
  static const Field<CareRecord, String> _f$recordId =
      Field('recordId', _$recordId, key: r'record_id');
  static String _$careRequirementId(CareRecord v) => v.careRequirementId;
  static const Field<CareRecord, String> _f$careRequirementId = Field(
      'careRequirementId', _$careRequirementId,
      key: r'care_requirement_id');
  static DateTime _$createdAt(CareRecord v) => v.createdAt;
  static const Field<CareRecord, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at');

  @override
  final MappableFields<CareRecord> fields = const {
    #recordId: _f$recordId,
    #careRequirementId: _f$careRequirementId,
    #createdAt: _f$createdAt,
  };

  static CareRecord _instantiate(DecodingData data) {
    return CareRecord(
        recordId: data.dec(_f$recordId),
        careRequirementId: data.dec(_f$careRequirementId),
        createdAt: data.dec(_f$createdAt));
  }

  @override
  final Function instantiate = _instantiate;

  static CareRecord fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CareRecord>(map);
  }

  static CareRecord fromJson(String json) {
    return ensureInitialized().decodeJson<CareRecord>(json);
  }
}

mixin CareRecordMappable {
  String toJson() {
    return CareRecordMapper.ensureInitialized()
        .encodeJson<CareRecord>(this as CareRecord);
  }

  Map<String, dynamic> toMap() {
    return CareRecordMapper.ensureInitialized()
        .encodeMap<CareRecord>(this as CareRecord);
  }

  CareRecordCopyWith<CareRecord, CareRecord, CareRecord> get copyWith =>
      _CareRecordCopyWithImpl<CareRecord, CareRecord>(
          this as CareRecord, $identity, $identity);
  @override
  String toString() {
    return CareRecordMapper.ensureInitialized()
        .stringifyValue(this as CareRecord);
  }

  @override
  bool operator ==(Object other) {
    return CareRecordMapper.ensureInitialized()
        .equalsValue(this as CareRecord, other);
  }

  @override
  int get hashCode {
    return CareRecordMapper.ensureInitialized().hashValue(this as CareRecord);
  }
}

extension CareRecordValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CareRecord, $Out> {
  CareRecordCopyWith<$R, CareRecord, $Out> get $asCareRecord =>
      $base.as((v, t, t2) => _CareRecordCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CareRecordCopyWith<$R, $In extends CareRecord, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? recordId, String? careRequirementId, DateTime? createdAt});
  CareRecordCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CareRecordCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CareRecord, $Out>
    implements CareRecordCopyWith<$R, CareRecord, $Out> {
  _CareRecordCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CareRecord> $mapper =
      CareRecordMapper.ensureInitialized();
  @override
  $R call({String? recordId, String? careRequirementId, DateTime? createdAt}) =>
      $apply(FieldCopyWithData({
        if (recordId != null) #recordId: recordId,
        if (careRequirementId != null) #careRequirementId: careRequirementId,
        if (createdAt != null) #createdAt: createdAt
      }));
  @override
  CareRecord $make(CopyWithData data) => CareRecord(
      recordId: data.get(#recordId, or: $value.recordId),
      careRequirementId:
          data.get(#careRequirementId, or: $value.careRequirementId),
      createdAt: data.get(#createdAt, or: $value.createdAt));

  @override
  CareRecordCopyWith<$R2, CareRecord, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CareRecordCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
