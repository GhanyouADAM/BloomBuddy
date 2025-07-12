import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/screens/plant_screen.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/plant_provider.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlantWidget extends ConsumerStatefulWidget {
  const AddPlantWidget({super.key});
  @override
  ConsumerState<AddPlantWidget> createState() => _AddPlantWidgetState();
}

class _AddPlantWidgetState extends ConsumerState<AddPlantWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _specieController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _specieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     double wValue = ref.watch(wateringSliderProvider);
                                double fValue = ref.watch(
                                  fertilizingSliderProvider,
                                );
                                bool isWatering = ref.watch(isWateringProvider);
                                bool isFertilizing = ref.watch(
                                  isFertilizingProvider,
                                );
                                  double pValue = ref.watch(pruningSliderProvider);
                                bool isPruning = ref.watch(
                                  isPruningProvider,
                                );
    return Scaffold(
          appBar: AppBar(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: context.colorScheme.onPrimary,
            title: Text(
              'Ajouter une plante',
              style: context.txtTheme.headlineSmall!.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.primaryContainer.withValues(
                        alpha: 0.7,
                      ),
                      context.colorScheme.secondaryContainer.withValues(
                        alpha: 0.7,
                      ),
                      context.colorScheme.tertiaryContainer.withValues(
                        alpha: 0.7,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: context.screenheight * 0.04,
                  right: 8,
                  left: 8,
                ),
                child: Container(
                  height: 800,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: context.colorScheme.surfaceBright,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 22, 8, 0),
                    child: Column(
                      children: [

                        Flexible(
                          flex: 1,
                          child: Form(
                            child: Column(
                              children: [
                                Text(
                                  "Les informations sur la plante",
                                  textAlign: TextAlign.center,
                                  style: context.txtTheme.bodyLarge!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: context.colorScheme.primary,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3,
                                        color: context.colorScheme.primaryContainer,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                TextFormField(
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.green),
                                    ),
                                    label: Text('Nom de la plante'),
                                  ),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _specieController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.green),
                                    ),
                          
                                    label: Text('Espèce de la plante'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                         Flexible(
                          flex: 1,
                           child: Container(
                             height: 300,
                             width: double.infinity,
                             decoration: BoxDecoration(),
                             child: SingleChildScrollView(
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Flexible(
                                     flex: 1,
                                     child: Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.spaceEvenly,
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Text('Arrosage(Jour)', overflow: TextOverflow.ellipsis,),
                                         Checkbox(
                                           value: isWatering,
                                           onChanged: (w) {
                                             ref
                                                 .read(
                                                   isWateringProvider.notifier,
                                                 )
                                                 .state = w ?? false;
                                           },
                                         ),
                                         isWatering
                                             ?  Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 150
                                              ),
                                               child: Slider(
                                                //padding: EdgeInsets.all(24),
                                                 label: wValue.round().toString(),
                                                 value: wValue,
                                                 min: 0,
                                                 max: 100,
                                                 onChanged: (newValue) {
                                                   ref
                                                       .read(
                                                         wateringSliderProvider
                                                             .notifier,
                                                       )
                                                       .state = newValue;
                                                 },
                                               ).animate()
                                               .fade()
                                               ,
                                             ) :
                                             Text(
                                               "",
                                             ),
                                             isWatering ? Text(wValue.round().toString()) : Text('')
                                             
                                       ],
                                     ),
                                   ),
                               
                                   Flexible(
                                     flex: 1,
                                     child: Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.start,
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Text('Fertilisation(Semaines)', overflow: TextOverflow.ellipsis,),
                                         Checkbox(
                                           value: isFertilizing,
                                           onChanged: (f) {
                                             ref
                                                 .read(
                                                   isFertilizingProvider
                                                       .notifier,
                                                 )
                                                 .state = f ?? false;
                                           },
                                         ),
                                         isFertilizing
                                             ?
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 110
                                                ),
                                                child: Slider(

                                                 label:
                                                     fValue.round().toString(),
                                                 value: fValue,
                                                 min: 0,
                                                 max: 100,
                                                 onChanged: (newFvalue) {
                                                   ref
                                                       .read(
                                                         fertilizingSliderProvider
                                                             .notifier,
                                                       )
                                                       .state = newFvalue;
                                                 },
                                                                                             )
                                                                                             .animate()
                                                                                             .fade(),
                                              )
                                              : Text(
                                               "",
                                             ),
                                             isFertilizing ? Text(fValue.round().toString()) : Text('')
                                             
                                             
                                       ],
                                     ),
                                   ),
                                   
                                   Flexible(
                                     flex: 1,
                                     child: Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.start,
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Text('Taille(Mois)', overflow: TextOverflow.ellipsis,),
                                         Checkbox(
                                           value: isPruning,
                                           onChanged: (p) {
                                             ref
                                                 .read(
                                                   isPruningProvider
                                                       .notifier,
                                                 )
                                                 .state = p ?? false;
                                           },
                                         ),
                                         isPruning
                                             ? 
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: 150
                                                ),
                                                child: Slider(
                                                 label:
                                                     pValue.round().toString(),
                                                 value: pValue,
                                                 min: 0,
                                                 max: 100,
                                                 onChanged: (newPvalue) {
                                                   ref
                                                       .read(
                                                         pruningSliderProvider
                                                             .notifier,
                                                       )
                                                       .state = newPvalue;
                                                 },
                                                )
                                                .animate()
                                                .fade(),
                                              )
                                             :Text(
                                               "",
                                             ),
                                            isPruning ? Text(pValue.round().toString()) : Text('')
                                             
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                         
                                Flexible(

                                  flex: 1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 60,
                                        vertical: 17,
                                      ),
                                      shadowColor: context.colorScheme.primary,
                                      elevation: 5,
                                    ),
                                    onPressed: () {
                                    
                                      if (_titleController.text.isNotEmpty &&
                                          _specieController.text.isNotEmpty) {
                                  
                                        final title = _titleController.text;
                                        final specie = _specieController.text;
                                        final int? pruning;
                                        final int? fertilizing;
                                        final int? watering;
                                        if (isPruning == false || pValue == 0) {
                                          pruning = null;
                                        }else{
                                          pruning = pValue.round();
                                        }
                                        if (isFertilizing == false || fValue == 0) {
                                          fertilizing = null;
                                        }else{
                                          fertilizing = fValue.round();
                                        }
                                        if (isWatering == false || wValue == 0) {
                                          watering = null;
                                        }else{
                                          watering = wValue.round();
                                        }
                                        final plant = Plant(
                                          plantName: title,
                                          plantSpecie: specie,
                                          requirements: CareRequirements(
                                            fertilizingFrequencyWeeks: fertilizing,
                                            wateringFrequencyDays: watering,
                                            pruningFrequencyMonth: pruning,
                                          ),
                                        );
                                        showDialog(
                                          useSafeArea: true,
                                          context: context, builder: (ctx){
                                          return AlertDialog(
                                            
                                            title: Text("Confirmer les informations de la plantes", textAlign: TextAlign.center,),
                                            content: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text('Nom : $title'),
                                                SizedBox(height: 10,),
                                                Text('Espece : $specie'),
                                                SizedBox(height: 10,),
                                                Text(watering != null ? 'Arrosage tout les : $watering jours' : "Pas d'arrosage pour cette plante", textAlign: TextAlign.center,),
                                                SizedBox(height: 10,),
                                                Text(fertilizing != null ? 'Fertilisation toutes les : $fertilizing semaines' : 'Pas de fertilisation pour cette plante', textAlign: TextAlign.center,),
                                                SizedBox(height: 10,),
                                                 Text(pruning != null ? 'Taille tout les : $pruning mois(30j)' : 'Pas de taille pour cette plante', textAlign: TextAlign.center,),
                                                SizedBox(height: 25,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ElevatedButton(onPressed: (){
                                                      Navigator.of(context).pop();
                                                    }, child: Text('Annuler', style: TextStyle(color: context.colorScheme.error),)),
                                                    ElevatedButton(onPressed: (){
                                                      ref
                                            .read(plantNotifierProvider.notifier)
                                            .savePlant(plant);
                                                        
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>PlantScreen()));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: context.colorScheme.primary,
                                            content: Text(
                                              'Plante ajoutée avec succès',
                                            ),
                                          ),
                                        );
                                                    }, child: Text('Confirmer', style: TextStyle(color: context.colorScheme.primary),)),

                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                        
                                      } else {
                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: context.colorScheme.error,content: Text('Veuiller renseigner toutes les informations').animate().shimmer()));
                                      }
                                    },
                                    child: Text('Enregistrer la plante'),
                                  ),
                                ),
                      ],
                      
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fade(duration: 300.ms)
        .slideX(begin: 0.6, duration: 400.ms, curve: Curves.easeIn);
  }
}
