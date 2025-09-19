import 'package:bloom_buddy/src/core/async_widget.dart';
import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/core/notification_service.dart';
import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/care_records/domain/entities/care_requirements.dart';
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
  dynamic _processingCareId;
  final NotificationService notificationService = NotificationService();
  void newCareRecord(CareRequirements careRequirement) async {
    try {
      setState(() {
        _processingCareId = careRequirement.careId;
      });
      //Ajoute avant tout un record pour l'action de soin effectué
      await ref
          .read(supabaseCareRequirementsRepositoryProvider)
          .registerCareRecord(careRequirement.careId);

      //annule la notification créée a la acreation de la condition de soins
      await notificationService.cancelNotification(careRequirement.careId);

      //et enfin programme la prochaine notification pour la même durée
      await notificationService.advancedScheduledNotifications(
        careId: careRequirement.careId,
        title: 'Nouveau rappel pour ${careRequirement.careType} ',
        body: 'Votre prochain soin est ${careRequirement.careFrequency} jours',
        interval: careRequirement.careFrequency,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Confirmation du soin enregistré avec succès !'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la confirmation : $e')),
        );
      }
    } finally {
      setState(() {
        _processingCareId = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncPlants = ref.watch(plantStreamProvider);
    final selectedPlant = ref.watch(selectedPlantProvider);
    final asyncCareRequirements = selectedPlant != null
        ? ref.watch(careRequirementsStreamProvider(selectedPlant.plantId))
        : null;
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
            //Le contenu du container bas affiche la liste des boutons si une plante est selectionnée
            child: selectedPlant != null
                ? AsyncValueWidget(
                    value: asyncCareRequirements!,
                    data: (data) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final careRequirement = data[index];
                          final isThisOneLoading =
                              _processingCareId == careRequirement.careId;
                          return ElevatedButton(
                            onPressed: _processingCareId! - null
                                ? null
                                : () {
                                    newCareRecord(careRequirement);
                                  },
                            child: isThisOneLoading
                                ? LoadingWidget()
                                : Text(careRequirement.careType),
                          );
                        },
                      );
                    },
                  )
                : Center(child: Text('Choisir une plante')),
          ),
        ],
      ),
    );
  }
}
