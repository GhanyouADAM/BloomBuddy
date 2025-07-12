
import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/plant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_neumorphism_ultra/flutter_neumorphism_ultra.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../datasource/models/plant.dart';

class TitleCard extends ConsumerStatefulWidget {
  const TitleCard({super.key, required this.plant});
  final Plant plant;

  @override
  ConsumerState<TitleCard> createState() => _TitleCardState();
}

class _TitleCardState extends ConsumerState<TitleCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this,
    duration: Duration(seconds: 1)
    );
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return NeuContainer(
            height: 170,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text('Nom : ${widget.plant.plantName}', 
                           overflow: TextOverflow.ellipsis,
                          style: context.txtTheme.bodyLarge!.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 4),
                          child: Text('Espèce : ${widget.plant.plantSpecie}',
                          overflow: TextOverflow.ellipsis,
                           style: context.txtTheme.bodyMedium!.copyWith(
                            color: context.colorScheme.secondary,
                            fontWeight: FontWeight.w100
                          ),),
                        )
                    ],
                  ),
                ),
                 
                 Positioned(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                             blurRadius: 3,
                             color: Colors.black45,
                             offset: Offset(0, 2.7)
                          )
                        ]
                      ),
                       child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 150,
                            width: 300,
                            child: Image.asset('assets/images/plants_icons2.png',
                            fit: BoxFit.cover,
                            ),
                          ),
                        )
                     ),
                   ),
                 ),
                  Positioned(
                            bottom: 43,
                            right: 10,
                            width: 40,
                            height: 40,
                             child: Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black45,
            offset: Offset(0, 2.4),
          ),
        ],
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        color: Theme.of(context).colorScheme.surface,
        onPressed: () {
          _controller.reset(); // Réinitialise l'animation au début
          _controller.forward(); // Démarre l'animation
          setState(() {
            widget.plant.changedFavorite();
            ref.read(plantNotifierProvider.notifier).updatePlant(widget.plant);
          });
        },
        icon: widget.plant.isFavorite
            ? Icon(Icons.favorite)
                .animate(controller: _controller) // Liez l'AnimationController
                .scale(end: const Offset(1.2, 1.2), duration: const Duration(milliseconds: 200))
                .fade(end: 0.8) // Ajoutez un effet de fondu si vous le souhaitez
            : Icon(Icons.favorite_border)
                .animate(controller: _controller) // Liez l'AnimationController
                .scale(end: const Offset(1.2, 1.2), duration: const Duration(milliseconds: 200))
                .fade(end: 0.8), // Ajoutez un effet de fondu si vous le souhaitez
      ),
    ),
                           ),
              ],
            ),
           );
  }
}