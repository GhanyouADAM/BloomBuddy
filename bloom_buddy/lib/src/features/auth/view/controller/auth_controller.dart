import 'package:bloom_buddy/src/core/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/supabase_auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(supabaseClient);
});

final authStateChangesProvider = StreamProvider<SupabaseUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
