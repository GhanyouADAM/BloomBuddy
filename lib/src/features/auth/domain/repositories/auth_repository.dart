import "package:bloom_buddy/src/features/auth/domain/entities/user.dart";
import "package:supabase_flutter/supabase_flutter.dart" as supabase;

typedef SupabaseUser = supabase.User;

abstract class AuthRepository {
  Stream<SupabaseUser?> get authStateChanges;

  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createAccount(
    String email,
    String password,
    String firstName,
    String lastName,
  );
  Future<AppUser?> getUserInfo(String userId);
  Future<void> signOut();
}
