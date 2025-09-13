import 'package:bloom_buddy/src/features/auth/view/controller/auth_controller.dart';
import 'package:bloom_buddy/src/features/plants/view/providers/plant_filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider.dart';
import '../../data/supabase_plant_repository.dart';

final queryProvider = StateProvider<String?>((ref) => null);

final supabasePlantRepository = Provider<SupabasePlantRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabasePlantRepository(client);
});

final plantStreamProvider = StreamProvider((ref) {
  final searchTerm = ref.watch(queryProvider);
  final repository = ref.watch(supabasePlantRepository);
  final filter = ref.watch(plantFilterProvider);
  final user = ref.watch(authStateChangesProvider).asData?.value;
  if (user == null) throw Exception("utilisateur non connecte");
  return repository.watchPlants(user.id, filter, searchQuery: searchTerm);
});
final likeedPlantsStreamProvider = StreamProvider((ref) {
  final repository = ref.watch(supabasePlantRepository);
  final user = ref.watch(authStateChangesProvider).asData?.value;
  if (user == null) throw Exception("utilisateur non connecte");
  return repository.watchLikePlants(user.id);
});
final userProvider = FutureProvider((ref) async {
  final currentUser = ref.watch(authStateChangesProvider).asData?.value;
  if (currentUser == null) throw Exception("User neede");
  return await ref.read(authRepositoryProvider).getUserInfo(currentUser.id);
});
