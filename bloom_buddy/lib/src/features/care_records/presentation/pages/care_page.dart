import 'package:bloom_buddy/src/core/async_widget.dart';
import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/controller/providers.dart';
import 'package:bloom_buddy/src/features/plants/view/controllers/plant_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class CarePage extends ConsumerStatefulWidget {
  const CarePage({super.key});

  @override
  ConsumerState<CarePage> createState() => _CarePageState();
}

class _CarePageState extends ConsumerState<CarePage> {
  @override
  Widget build(BuildContext context) {
    final asyncPlants = ref.watch(plantStreamProvider);
    final selectedPlant = ref.watch(selectedPlantProvider);
    if (selectedPlant != null) {
      final asyncCareRequirements = ref.watch(
        careRequirementsStreamProvider(selectedPlant.plantId),
      );
    } else {
      final asyncCareRequirements = null;
    }
    return Scaffold(
      appBar: AppBar(title: Text('Soins')),
      body: Column(
        children: [
          AsyncValueWidget(
            value: asyncPlants,
            data: (plants) {
              return DropdownButton(
                borderRadius: AppBorders.circularSmall,
                icon: Icon(Icons.arrow_downward_rounded, color: Colors.green),

                value: selectedPlant,
                items: plants.map((plant) {
                  return DropdownMenuItem(
                    value: plant,
                    child: Text(plant.plantName),
                  );
                }).toList(),
                onChanged: (plant) {
                  ref.read(selectedPlantProvider.notifier).state = plant;
                },
              );
            },
          ),
          SizedBox(height: AppSpacing.xxl),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.none),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: selectedPlant != null
                        ? Lottie.asset(
                            height: AppSpacing.xxl * 4,
                            "assets/animations/Lotus Flower.json",
                          )
                        : Container(
                            height: AppSpacing.xxl * 2,
                            width: AppSpacing.xxl * 2,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.local_florist,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    selectedPlant != null
                        ? selectedPlant.plantName
                        : ' Aucune plante selectionnée',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            height: AppSpacing.xxl * 7,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppBorders.radiusMedium),
                topRight: Radius.circular(AppBorders.radiusMedium),
              ),
            ),
            child: Wrap(),
          ),
        ],
      ),
    );
  }
}
