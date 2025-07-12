// lib/features/plants/presentation/screens/plant_detail_screen.dart
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/plant_details/image_title.dart';
import 'package:definitive_bloom_buddy/features/plants/datasource/models/plant.dart';
// Importe le nouveau provider et le modèle CareRecord
import 'package:definitive_bloom_buddy/features/care_records/presentation/state/care_countdown_provider.dart';
import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
// Importe le provider pour ajouter un soin (si tu en as un)
import 'package:definitive_bloom_buddy/features/care_records/presentation/state/care_record_provider.dart'; // Assure-toi que le chemin est correct


// Change en ConsumerStatefulWidget pour utiliser initState
class AiPlantDetailsScreen extends ConsumerStatefulWidget {
  const AiPlantDetailsScreen({super.key, required this.plant});

  final Plant plant;

  @override
  ConsumerState<AiPlantDetailsScreen> createState() => _AiPlantDetailScreenState();
}

class _AiPlantDetailScreenState extends ConsumerState<AiPlantDetailsScreen> with SingleTickerProviderStateMixin {

late AnimationController _animationController;
@override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      
      vsync: this);
    // Rafraîchit les compteurs quand l'écran est affiché pour la première fois
    // Utilise Future.microtask pour appeler après la fin du premier build
    Future.microtask(() => ref.read(careCountdownProvider(widget.plant.plantId).notifier).refreshAllCounters());
  }
  
  // Fonction pour afficher une ligne de soin
  Widget _buildCareRow(BuildContext context, Caretype caretype, int? daysRemaining) {
    String text;
    Color indicatorColor = Colors.grey; // Couleur par défaut

    if (daysRemaining == null) {
      text = "Non requis";
    } else if (daysRemaining == 0) {
      text = "Aujourd'hui / En retard";
      indicatorColor = Colors.red; // Rouge si c'est dû aujourd'hui ou en retard
    } else if (daysRemaining == 1) {
      text = "Demain";
       indicatorColor = Colors.orange; // Orange si c'est pour demain
    } else {
      text = "Dans $daysRemaining jours";
       indicatorColor = Colors.green; // Vert s'il reste du temps
    }

     // Détermine l'icône et le nom basé sur Caretype
    IconData iconData;
    String careName;
    switch (caretype) {
      case Caretype.watering:
        iconData = Icons.water_drop_outlined;
        careName = "Arrosage";
        break;
      case Caretype.fertilizing:
        iconData = Icons.local_florist_outlined; // Ou une icône d'engrais
        careName = "Fertilisation";
        break;
      case Caretype.pruning:
        iconData = Icons.content_cut_outlined;
        careName = "Taille";
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(iconData, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 15),
          Expanded(child: Text(careName, overflow: TextOverflow.ellipsis,style: context.txtTheme.bodyLarge)),
          Text(text,overflow: TextOverflow.ellipsis, style: context.txtTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: daysRemaining == null ? Colors.transparent : indicatorColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }


  // --- Fonction pour simuler l'ajout d'un soin ---
  // Remplace ceci par ta vraie logique d'ajout de soin
  void _performCare(Caretype careTypeToPerform) {
      final plant = widget.plant; // ou ref.read(plantProvider...) si tu préfères
      final newRecord = CareRecord(
        caretype: careTypeToPerform,
        careDate: DateTime.now(),
        note: "Soin effectué via bouton détail" // Optionnel
      );

      // Appelle la fonction d'ajout (qui contient la logique de sauvegarde + reset)
      // Assure-toi d'avoir une fonction comme celle-ci quelque part,
      // peut-être dans ton CareRecordNotifier ou directement ici si plus simple.
      // Note: La fonction 'addCareRecordAndResetCounter' est un exemple.
      // Tu devras adapter cela à ta structure. Le point clé est l'appel à
      // ref.read(careCountdownProvider(plant.plantId).notifier).careWasPerformed(careTypeToPerform);
      // APRES la sauvegarde réussie.

      // Exemple d'appel direct (si tu n'as pas de Notifier dédié pour ajouter)
      final careRepository = ref.read(careRepositoryProvider);
      careRepository.saveCareRecord(plant, newRecord).then((_) {
          print("Soin ${careTypeToPerform.name} enregistré pour ${plant.plantName}.");
          ref.read(careCountdownProvider(plant.plantId).notifier).careWasPerfomed(careTypeToPerform);
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${_getCareName(careTypeToPerform)} enregistré !'))
           );
           // Optionnel: rafraîchir immédiatement tous les compteurs si nécessaire
           // ref.read(careCountdownProvider(plant.plantId).notifier).refreshAllCounters();
      }).catchError((error) {
           print("Erreur lors de l'enregistrement du soin: $error");
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur lors de l\'enregistrement du soin.'), backgroundColor: Colors.red)
           );
      });


      print("Action: Procéder au soin de type ${careTypeToPerform.name}");
      // Ici, tu devrais ouvrir un dialogue/écran pour confirmer/ajouter des notes,
      // puis enregistrer le CareRecord via ton repository/notifier.
      // Après l'enregistrement réussi, appelle :
      // ref.read(careCountdownProvider(widget.plant.plantId).notifier).careWasPerformed(careTypeToPerform);
  }

  String _getCareName(Caretype caretype) {
     switch (caretype) {
      case Caretype.watering: return "Arrosage";
      case Caretype.fertilizing: return "Fertilisation";
      case Caretype.pruning: return "Taille";
    }
  }
// --- Fin de la fonction de simulation ---


  @override
  Widget build(BuildContext context) {
    // Écoute l'état du provider de countdown pour CETTE plante
    final countdownState = ref.watch(careCountdownProvider(widget.plant.plantId));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        title: Text('Détails de ${widget.plant.plantName}'),
          actions: [
            // Bouton pour rafraîchir manuellement les compteurs
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _animationController.forward();
                ref.read(careCountdownProvider(widget.plant.plantId).notifier).refreshAllCounters();
                
              },
              tooltip: 'Rafraîchir les compteurs',
            ),
          ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              child: TitleCard(plant: widget.plant).animate(
                controller: _animationController
                ).shimmer(duration: 1200.ms) // Ton widget existant
          ),
          const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20),
           Text(
            'Prochains Soins :',
            style: context.txtTheme.headlineSmall?.copyWith(color: context.colorScheme.primary),
           ),
           const SizedBox(height: 10),

          // Affiche l'état du countdown
          countdownState.when(
            data: (daysMap) {
              // Construit la liste des lignes de soins
              return Column(
                children: Caretype.values.map((caretype) {
                   // Affiche seulement si une fréquence est définie
                    bool isRequired = false;
                     switch (caretype) {
                      case Caretype.watering: isRequired = widget.plant.requirements.wateringFrequencyDays != null && widget.plant.requirements.wateringFrequencyDays! > 0; break;
                      case Caretype.fertilizing: isRequired = widget.plant.requirements.fertilizingFrequencyWeeks != null && widget.plant.requirements.fertilizingFrequencyWeeks! > 0; break;
                      case Caretype.pruning: isRequired = widget.plant.requirements.pruningFrequencyMonth != null && widget.plant.requirements.pruningFrequencyMonth! > 0; break;
                    }
                    // Affiche la ligne seulement si le soin est requis pour cette plante
                    if (isRequired) {
                       return _buildCareRow(context, caretype, daysMap[caretype]);
                    } else {
                      return const SizedBox.shrink(); // Ne rien afficher si non requis
                    }

                }).toList(),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text('Erreur de calcul: $error')),
            ),
          ),
           const Spacer(), // Pour pousser le bouton vers le bas

        ],
      ),
        // Adapte ton FloatingActionButton pour proposer les actions de soin
       floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        onPressed: () {
          // Ouvre un menu ou un dialogue pour choisir le type de soin à effectuer
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext bContext) {
              return Container(
                //height: context.screenheight * 0.5,
                //width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Wrap( // Utilise Wrap pour que ça s'adapte
                  spacing: 10, // Espace horizontal
                  runSpacing: 10, // Espace vertical
                  children: Caretype.values.map((caretype) {
                     // Affiche le bouton seulement si le soin est requis pour cette plante
                    bool isRequired = false;
                     switch (caretype) {
                      case Caretype.watering: isRequired = widget.plant.requirements.wateringFrequencyDays != null && widget.plant.requirements.wateringFrequencyDays! > 0; break;
                      case Caretype.fertilizing: isRequired = widget.plant.requirements.fertilizingFrequencyWeeks != null && widget.plant.requirements.fertilizingFrequencyWeeks! > 0; break;
                      case Caretype.pruning: isRequired = widget.plant.requirements.pruningFrequencyMonth != null && widget.plant.requirements.pruningFrequencyMonth! > 0; break;
                    }
                    if (isRequired) {
                      return ElevatedButton.icon(
                        icon: Icon(_getIconForCareType(caretype)),
                        label: Text('Marquer ${_getCareName(caretype)}'),
                        onPressed: () {
                          _animationController.forward();
                           Navigator.pop(bContext); // Ferme le bottom sheet
                          _performCare(caretype); // Lance l'action de soin
                        },
                      );
                    } else {
                       return const SizedBox.shrink();
                    }
                  }).toList(),
                ),
              );
            },
          );
        },
        label: const Text('Effectuer un Soin'),
        icon: const Icon(Icons.content_paste_go), // Icône plus appropriée peut-être
      ),
    );
  }
   IconData _getIconForCareType(Caretype caretype) {
    switch (caretype) {
      case Caretype.watering: return Icons.water_drop_outlined;
      case Caretype.fertilizing: return Icons.local_florist_outlined;
      case Caretype.pruning: return Icons.content_cut_outlined;
    }
  }
}