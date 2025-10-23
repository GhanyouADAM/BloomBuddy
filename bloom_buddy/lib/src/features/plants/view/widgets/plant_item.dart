import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/plants/view/pages/plant_details_page.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/plant_form.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/plant.dart';

class PlantItem extends ConsumerWidget {
  const PlantItem({super.key, required this.plant});
  final Plant plant;

  void _goToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlantDetailsPage(plant: plant)),
    );
  }

  void _openEditForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppBorders.radiusMedium),
        ),
      ),
      builder: (_) => PlantForm(plantToUpdate: plant, isUpating: true),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    return Card(
      elevation: 4,
      // surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(borderRadius: AppBorders.circularMedium),
      child: InkWell(
        borderRadius: AppBorders.circularMedium,
        onTap: () => _openEditForm(context),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Hero(
                tag: "plant_image_${plant.plantId}",
                child: Container(
                  width: AppSpacing.xxl,
                  height: AppSpacing.xxl,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.green.shade50, Colors.green.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: ClipOval(
                    child: Lottie.asset(
                      height: AppSpacing.xxl * 2,
                      "assets/animations/Lotus Flower.json",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.plantName,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      plant.plantSpecie,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorders.circularMedium,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.green.shade50,
                  foregroundColor: Colors.green.shade700,
                ),
                icon: const Icon(Icons.edit_outlined),
                label: const Text("Details"),
                onPressed: () => _goToDetails(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
