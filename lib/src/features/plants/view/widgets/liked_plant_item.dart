import 'package:bloom_buddy/src/core/loading_widget.dart';
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.green.shade50.withOpacity(0.3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: 264,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "liked_plant_image_${plant.plantId}",
                        child: Container(
                          width: 78,
                          height: 78,
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
                          padding: const EdgeInsets.all(6),
                          child: ClipOval(
                            child: Lottie.asset(
                              "assets/animations/Lotus Flower.json",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
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
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(12),
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
                                      const SizedBox(width: 4),
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
                            const SizedBox(height: 6),
                            Text(
                              plant.plantSpecie,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: Colors.grey.shade600,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                            const SizedBox(height: 8),
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

                  const SizedBox(height: 12),

                  // mini-divider
                  Divider(color: Colors.grey.shade200, height: 1, thickness: 1),

                  const SizedBox(height: 10),

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
                          height: 44,
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
