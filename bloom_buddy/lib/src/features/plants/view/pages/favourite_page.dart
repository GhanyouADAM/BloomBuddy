import 'package:bloom_buddy/src/core/async_widget.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/plants/view/controllers/plant_controller.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/plant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final asyncPlantData = ref.watch(likeedPlantsStreamProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Plantes favorites")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xl),
          child: SizedBox(
            child: AsyncValueWidget(
              value: asyncPlantData,
              data: (data) {
                if (data.isEmpty) {
                  return Center(
                    child: Text("Les plantes favorites apparaîtront ici."),
                  );
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    itemCount: data.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final plant = data[index];
                      return PlantItem(plant: plant);
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
