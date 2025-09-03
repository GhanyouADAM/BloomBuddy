import 'dart:math';

import 'package:bloom_buddy/src/features/plants/view/controllers/plant_controller.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/liked_plant_item.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/plant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/plant.dart';

class PlantListWidget extends ConsumerWidget {
  const PlantListWidget({
    super.key,
    required this.plants,
    this.isLikePlant = false,
  });
  final List<Plant> plants;
  final bool isLikePlant;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return !isLikePlant
        ? ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Dismissible(
                  key: ValueKey(plant.plantId),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red.shade100,
                    ),
                    child: Icon(Icons.delete_sweep, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    try {
                      await ref
                          .read(supabasePlantRepository)
                          .deletePlant(plant.plantId);
                      ref.invalidate(plantStreamProvider);
                      return true;
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
                      }
                      return false;
                    }
                  },
                  child: plant.isLiked
                      ? PlantItem(plant: plant)
                            .animate(
                              key: ValueKey(
                                '${plant.plantId}_${plant.isLiked}',
                              ),
                            )
                            .shimmer(
                              angle: sqrt1_2,
                              curve: Curves.slowMiddle,
                              color: Colors.green,
                              duration: 1550.ms,
                            )
                            .fadeIn(duration: 400.ms)
                      : PlantItem(
                          plant: plant,
                        ).animate().fadeIn(duration: 400.ms),
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: plants.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: LikedPlantItem(plant: plant),
              );
            },
          );
  }
}
