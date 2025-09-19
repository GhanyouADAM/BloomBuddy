import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/controller/providers.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/widgets/care_requirements_list.dart';
import 'package:bloom_buddy/src/features/plants/domain/entities/plant.dart';
import 'package:bloom_buddy/src/features/plants/view/pages/plant_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class LikedPlantItem extends ConsumerWidget {
  const LikedPlantItem({super.key, required this.plant});
  final Plant plant;

  void _goToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlantDetailsPage(plant: plant)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final careRequirements = ref.watch(
      careRequirementsStreamProvider(plant.plantId),
    );

    return InkWell(
      onTap: () => _goToDetails(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: AppBorders.circularLarge),
        elevation: 6,
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.green.shade50.withValues(alpha: 0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SizedBox(
              width: AppSpacing.xxl * 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "liked_plant_image_${plant.plantId}",
                        child: Container(
                          width: AppSpacing.xxl * 2,
                          height: AppSpacing.xxl * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade100,
                                Colors.green.shade300,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.shade100.withOpacity(0.6),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: ClipOval(
                            child: Lottie.asset(
                              "assets/animations/Lotus Flower.json",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    plant.plantName,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.shade900,
                                        ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm,
                                    vertical: AppSpacing.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: AppBorders.circularMedium,
                                    border: Border.all(
                                      color: Colors.green.shade100,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: AppSpacing.xs),
                                      Text(
                                        "Favori",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              plant.plantSpecie,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: Colors.grey.shade600,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            if ((plant.plantDescription ?? '').isNotEmpty)
                              Text(
                                plant.plantDescription!.length > 80
                                    ? '${plant.plantDescription!.substring(0, 80)}...'
                                    : plant.plantDescription!,
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      color: Colors.grey.shade700,
                                      height: 1.2,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // mini-divider
                  Divider(color: Colors.grey.shade200, height: 1, thickness: 1),

                  const SizedBox(height: AppSpacing.md),

                  // Care requirements area (keeps existing logic & widget)
                  careRequirements.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Aucune condition de soin définie",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.grey.shade600),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: AppSpacing.xxl,
                          child: CareRequirementsList(
                            careRequirements: data,
                            plant: plant,
                          ),
                        );
                      }
                    },
                    error: (e, s) => Align(
                      child: Text(
                        e.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    loading: () => const Align(child: LoadingWidget()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
