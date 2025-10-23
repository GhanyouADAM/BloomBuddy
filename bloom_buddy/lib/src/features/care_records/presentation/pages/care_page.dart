import 'package:bloom_buddy/src/core/async_widget.dart';
import 'package:bloom_buddy/src/core/notification_service.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/care_records/domain/entities/care_requirements.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/controller/providers.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/widgets/care_filter.dart';
import 'package:bloom_buddy/src/features/plants/domain/entities/plant.dart';
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
      //Met a jour la conditions de soin pour la confirmation
      await ref
          .read(supabaseCareRequirementsRepositoryProvider)
          .updateCareRequirements(
            careRequirement.copyWith(
              status: 'Scheduled',
              lastCareDate: DateTime.now(),
              nextCareDate: DateTime.now().add(
                Duration(days: careRequirement.careFrequency),
              ),
            ),
          );
      //annule la notification créée a la acreation de la condition de soins
      await notificationService.cancelNotification(careRequirement.careId);

      //et enfin programme la prochaine notification pour la même durée
      await notificationService.advancedScheduledNotifications(
        careId: careRequirement.careId,
        title: 'Nouveau rappel pour ${careRequirement.careType} ',
        body:
            'Votre plante ${ref.read(selectedPlantProvider)?.plantName} a besoin de ${careRequirement.careType} aujourd\'hui',
        interval: careRequirement.careFrequency,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            content: Text(
              'Confirmation du soin enregistré avec succès ! Votre '
              'prochain rappel pour ${careRequirement.careType} est dans ${careRequirement.careFrequency} jours.',
            ),
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

  final Map<String, Color> careStatusColor = {
    'Scheduled': Colors.green,
    'due': Colors.orange,
    'late': Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    final asyncPlants = ref.watch(plantStreamProvider);
    final selectedPlant = ref.watch(selectedPlantProvider);
    final asyncCareRequirements = selectedPlant != null
        ? ref.watch(
            careRequirementsByStatusStreamProvider(selectedPlant.plantId),
          )
        : null;
    return Scaffold(
      appBar: AppBar(title: Text('Soins')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: AsyncValueWidget(
            value: asyncPlants,
            data: (plants) {
              if (plants.isEmpty) {
                return Center(
                  child: Text(
                    "Créer des plantes avant de revenir sur cet écran",
                  ),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(0),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Selection de plante',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          buildDropdownButton(selectedPlant, plants),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    selectedPlant == null
                        ? Center(child: Text('Aucune plante à afficher'))
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withAlpha(0),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Lottie.asset(
                                        height: AppSpacing.xxxl * 4,
                                        'assets/animations/Lotus Flower.json',
                                      ),
                                      SizedBox(height: AppSpacing.md),
                                      Text(
                                        selectedPlant.plantName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withAlpha(0),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Programme des soins',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(height: AppSpacing.xs),
                                      CareFilter(),
                                    ],
                                  ),
                                ),
                                SizedBox(height: AppSpacing.xs),
                                AsyncValueWidget(
                                  value: asyncCareRequirements!,

                                  data: (careRequirements) {
                                    if (careRequirements.isEmpty) {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withAlpha(0),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: Colors.green,
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Soins',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              SizedBox(height: AppSpacing.xs),
                                              Text(
                                                'Aucun soin a afficher pour cette plante',
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withAlpha(0),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: Colors.green,
                                          ),
                                        ),
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: careRequirements.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: AppSpacing.md),

                                          itemBuilder: (context, index) {
                                            final careRequirement =
                                                careRequirements[index];
                                            final isProcessing =
                                                _processingCareId ==
                                                careRequirement.careId;
                                            return ListTile(
                                              tileColor:
                                                  careStatusColor[careRequirement
                                                          .status]!
                                                      .withValues(alpha: 0.1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),

                                                side: BorderSide(
                                                  color:
                                                      careStatusColor[careRequirement
                                                          .status] ??
                                                      Colors.grey,
                                                  width: 1,
                                                ),
                                              ),
                                              title: Text(
                                                careRequirement.careType,
                                              ),
                                              subtitle: Text(
                                                'Tous les ${careRequirement.careFrequency} jours',
                                              ),
                                              trailing: isProcessing
                                                  ? SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                    )
                                                  : MaterialButton(
                                                      onPressed:
                                                          careRequirement
                                                                  .status ==
                                                              'Scheduled'
                                                          ? null
                                                          : () {
                                                              newCareRecord(
                                                                careRequirement,
                                                              );
                                                            },
                                                      color:
                                                          careStatusColor[careRequirement
                                                              .status],
                                                      textColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                      child: Text('Confirmer'),
                                                    ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  DropdownButton<Plant> buildDropdownButton(
    Plant? selectedPlant,
    List<Plant> plants,
  ) {
    return DropdownButton(
      hint: Text('Sélectionner une plante'),
      borderRadius: BorderRadius.circular(8),
      elevation: 7,
      isExpanded: true,
      icon: Icon(Icons.arrow_downward_sharp),
      value: selectedPlant,
      items: plants.map((plant) {
        return DropdownMenuItem(
          value: plant,
          child: Text(plant.plantName, style: TextStyle(fontSize: 16)),
        );
      }).toList(),
      onChanged: (p) {
        ref.read(selectedPlantProvider.notifier).state = p;
      },
    );
  }
}
