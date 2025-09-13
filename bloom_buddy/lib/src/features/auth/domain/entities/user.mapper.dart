// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user.dart';

class AppUserMapper extends ClassMapperBase<AppUser> {
  AppUserMapper._();

  static AppUserMapper? _instance;
  static AppUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppUserMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppUser';

  static String _$userId(AppUser v) => v.userId;
  static const Field<AppUser, String> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static String _$email(AppUser v) => v.email;
  static const Field<AppUser, String> _f$email = Field('email', _$email);
  static String _$firstName(AppUser v) => v.firstName;
  static const Field<AppUser, String> _f$firstName =
      Field('firstName', _$firstName, key: r'first_name');
  static String _$lastName(AppUser v) => v.lastName;
  static const Field<AppUser, String> _f$lastName =
      Field('lastName', _$lastName, key: r'last_name');
  static DateTime _$createdAt(AppUser v) => v.createdAt;
  static const Field<AppUser, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at');
  static DateTime _$updatedAt(AppUser v) => v.updatedAt;
  static const Field<AppUser, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt, key: r'updated_at');

  @override
  final MappableFields<AppUser> fields = const {
    #userId: _f$userId,
    #email: _f$email,
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static AppUser _instantiate(DecodingData data) {
    return AppUser(
        userId: data.dec(_f$userId),
        email: data.dec(_f$email),
        firstName: data.dec(_f$firstName),
        lastName: data.dec(_f$lastName),
        createdAt: data.dec(_f$createdAt),
        updatedAt: data.dec(_f$updatedAt));
  }

  @override
  final Function instantiate = _instantiate;

  static AppUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppUser>(map);
  }

  static AppUser fromJson(String json) {
    return ensureInitialized().decodeJson<AppUser>(json);
  }
}

mixin AppUserMappable {
  String toJson() {
    return AppUserMapper.ensureInitialized()
        .encodeJson<AppUser>(this as AppUser);
  }

  Map<String, dynamic> toMap() {
    return AppUserMapper.ensureInitialized()
        .encodeMap<AppUser>(this as AppUser);
  }

  AppUserCopyWith<AppUser, AppUser, AppUser> get copyWith =>
      _AppUserCopyWithImpl<AppUser, AppUser>(
          this as AppUser, $identity, $identity);
  @override
  String toString() {
    return AppUserMapper.ensureInitialized().stringifyValue(this as AppUser);
  }

  @override
  bool operator ==(Object other) {
    return AppUserMapper.ensureInitialized()
        .equalsValue(this as AppUser, other);
  }

  @override
  int get hashCode {
    return AppUserMapper.ensureInitialized().hashValue(this as AppUser);
  }
}

extension AppUserValueCopy<$R, $Out> on ObjectCopyWith<$R, AppUser, $Out> {
  AppUserCopyWith<$R, AppUser, $Out> get $asAppUser =>
      $base.as((v, t, t2) => _AppUserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppUserCopyWith<$R, $In extends AppUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? userId,
      String? email,
      String? firstName,
      String? lastName,
      DateTime? createdAt,
      DateTime? updatedAt});
  AppUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppUser, $Out>
    implements AppUserCopyWith<$R, AppUser, $Out> {
  _AppUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppUser> $mapper =
      AppUserMapper.ensureInitialized();
  @override
  $R call(
          {String? userId,
          String? email,
          String? firstName,
          String? lastName,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      $apply(FieldCopyWithData({
        if (userId != null) #userId: userId,
        if (email != null) #email: email,
        if (firstName != null) #firstName: firstName,
        if (lastName != null) #lastName: lastName,
        if (createdAt != null) #createdAt: createdAt,
        if (updatedAt != null) #updatedAt: updatedAt
      }));
  @override
  AppUser $make(CopyWithData data) => AppUser(
      userId: data.get(#userId, or: $value.userId),
      email: data.get(#email, or: $value.email),
      firstName: data.get(#firstName, or: $value.firstName),
      lastName: data.get(#lastName, or: $value.lastName),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt));

  @override
  AppUserCopyWith<$R2, AppUser, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
