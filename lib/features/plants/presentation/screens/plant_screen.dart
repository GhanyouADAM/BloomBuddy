import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/plant_provider.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/ui_provider.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/add_plant_widget.dart';
//import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/add_plant_widget.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/animated_filter_chips_widget.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/care_history_widgets.dart';
//import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/plant_details/image_title.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/plant_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantScreen extends ConsumerStatefulWidget {
  const PlantScreen({super.key});

  @override
  ConsumerState<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends ConsumerState<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncPlants = ref.watch(plantNotifierProvider);
    final currentFilter = ref.watch(plantFilterProvider);
    
    final index = ref.watch(indexProvider);
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        actions: [
          IconButton(
            color: context.colorScheme.onPrimary,
            onPressed: (){
            showDialog(context: context, builder: (ctx){
              return AlertDialog(
                content: Text('Coming soon...'),
              );
            });
          }, icon: Icon(Icons.info_outline_rounded))
        ],
        backgroundColor: context.colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(37),
            child: Image.asset(
              'assets/images/round_circle_leaves_logo.jpg',
              //color: context.colorScheme.primary,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          'Bloom buddy',
          style: context.txtTheme.headlineSmall!.copyWith(
            color: context.colorScheme.onPrimary,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: SearchBar(
                    onChanged: (value){
                      ref.read(searchQueryProvider.notifier).state= value;
                    },
                    leading: Icon(Icons.search, color: Colors.black45),
                    hintText: 'Rechercher une plante',
                    hintStyle: WidgetStatePropertyAll(
                      context.txtTheme.bodyMedium!.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.4,
                          ),
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.onPrimary,
                      child: IconButton(onPressed:(){
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context, builder: (ctx)=>CareHistoryWidgets());
                      },icon:Icon(Icons.history)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AnimatedFilterChips(),
            ),
          ),
          Flexible(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 8, right: 8),
              child: Container(
                key: ValueKey(index),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.primaryContainer.withValues(
                        alpha: 0.5,
                      ),
                      context.colorScheme.secondaryContainer.withValues(
                        alpha: 0.5,
                      ),
                      context.colorScheme.tertiaryContainer.withValues(
                        alpha: 0.5,
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: asyncPlants.when(
                    data: (plants) {
                      if (plants.isEmpty) {
                        return Center(
                          child: switch (currentFilter) {
                            PlantFilter.plants =>  Text('Ajouter des plantes').animate().fadeIn(),
                            PlantFilter.favorites => Text("Aucune plantes dans vos favoris").animate().fade(),
                            PlantFilter.urgent => Text('Aucune plante ici pour l\'instant').animate().fade()
                          }
                             
                        );
                      } else {
                        return ListView.builder(
                              itemCount: plants.length,
                              itemBuilder: (ctx, index) {
                                final plant = plants[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Dismissible(
                                    key: ValueKey(plant.plantId),
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        color:
                                            context.colorScheme.errorContainer,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        Icons.delete_sweep_rounded,
                                        color:
                                            context
                                                .colorScheme
                                                .onErrorContainer,
                                      ),
                                    ),
                                    direction: DismissDirection.endToStart,

                                    onDismissed: (direction) {
                                      ref
                                          .read(plantNotifierProvider.notifier)
                                          .deletePlant(plant.plantId);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              context.colorScheme.primary,
                                          content: Text(
                                            'Plante supprimée avec succès',
                                            style: TextStyle(
                                              color:
                                                  context.colorScheme.onPrimary,
                                            ),
                                          ).animate(
                                            onPlay: (controller) => controller.repeat(),
                                          )
                                          .shimmer(
                                            angle: 9,
                                            color: Colors.white,
                                            duration: 3.seconds
                                          )
                                          ,
                                        )
                                        ,
                                      )
                                      ;
                                    },
                                    child: PlantItemWidget(plant: plant)
                                    .animate()
                                    .fade(),
                                  ),
                                );
                              },
                            )
                            .animate(
                            )
                            .fadeIn(duration: 400.ms)
                            .slideX(
                              begin: -0.3,
                              duration: 300.ms,
                              curve: Curves.easeOut,
                            )
                            
                            ;
                      }
                    },
                    error: (e, stackTrace) => Center(child: Text('Erreur :$e')),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => AddPlantWidget()));
        },
        label: Text('Nouvelle plante'),
        icon: Icon(Icons.add),
      ),
    ).animate()
    .fade(duration: 500.ms)
    .shimmer(duration: 500.ms)
    ;
  }
}
