import 'package:bloom_buddy/src/features/auth/domain/entities/user.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabaseClient;

  SupabaseAuthRepository(this._supabaseClient);

  @override
  Stream<SupabaseUser?> get authStateChanges => _supabaseClient
      .auth
      .onAuthStateChange
      .map((state) => state.session?.user);

  @override
  Future<void> createAccount(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      final credentials = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'first_name': firstName, 'last_name': lastName},
      );

      if (credentials.user != null) {
        final user = credentials.user!;
        await _supabaseClient.from('profiles').upsert({
          "user_id": user.id,
          'email': user.email,
          'first_name': firstName,
          'last_name': lastName,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }, onConflict: "user_id");
      }
    } on AuthException catch (error) {
      if (kDebugMode) {
        print('Auth error during account creation: ${error.message}');
      }
      rethrow;
    } catch (error) {
      if (kDebugMode) {
        print('Unexpected error during account creation: $error');
      }
      rethrow;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      if (kDebugMode) {
        print('Auth error during sign in: ${error.message}');
      }
      rethrow;
    } catch (error) {
      if (kDebugMode) {
        print('Unexpected error during sign in: $error');
      }
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } on AuthException catch (error) {
      if (kDebugMode) {
        print('Auth error during sign out: ${error.message}');
      }
      rethrow;
    } catch (error) {
      if (kDebugMode) {
        print('Unexpected error during sign out: $error');
      }
      rethrow;
    }
  }

  @override
  Future<AppUser?> getUserInfo(String userId) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw Exception("User needed");
    final map = await _supabaseClient
        .from('profiles')
        .select()
        .eq("user_id", userId)
        .single();
    final appUser = AppUserMapper.fromMap(map);
    return map.isEmpty ? null : appUser;
  }
}
