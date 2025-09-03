import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

@MappableClass(
  caseStyle: CaseStyle.snakeCase
)
class AppUser with AppUserMappable {
   String userId;
   String email;
   String firstName;
   String lastName;
   DateTime createdAt;
   DateTime updatedAt;
  AppUser({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
  });

}
