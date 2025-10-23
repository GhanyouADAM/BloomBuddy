import 'package:bloom_buddy/src/core/provider.dart';
import 'package:bloom_buddy/src/features/care_records/domain/repositories/care_requirements_repository.dart';
import 'package:bloom_buddy/src/features/plants/domain/entities/plant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/supabe_care_requirements_repository.dart';
import '../../domain/entities/care_requirements.dart';

final supabaseCareRequirementsRepositoryProvider =
    Provider<CareRequirementsRepository>((ref) {
      final client = ref.watch(supabaseClientProvider);

      return SupabaseCareRequirementsRepsoitory(client);
    });

final careRequirementsStreamProvider = StreamProvider.family
    .autoDispose<List<CareRequirements>, String>((ref, plantId) {
      final repository = ref.watch(supabaseCareRequirementsRepositoryProvider);
      return repository.watchCareRequirements(plantId);
    });

final selectedPlantProvider = StateProvider<Plant?>((ref) => null);

final careRequirementsStreamFilter = StateProvider<String>(
  (ref) => 'Scheduled',
);

final careRequirementsByStatusStreamProvider = StreamProvider.family
    .autoDispose<List<CareRequirements>, String>((ref, plantId) {
      final status = ref.watch(careRequirementsStreamFilter);
      final repository = ref.watch(supabaseCareRequirementsRepositoryProvider);
      return repository.watchCareRequirementsByStatus(plantId, status);
    });
