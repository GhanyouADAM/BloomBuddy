import 'dart:ui';

import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/screens/plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan avec couleur uniforme
          SizedBox(
            height: 700,
            width: double.infinity,
            child: Image.asset(
              'assets/images/top-view-leaf-branches-gray-surface.jpg',
              fit: BoxFit.cover,
            ), // Ta couleur d'arrière-plan
          ),

          // Effet de verre
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black.withValues(
                alpha: 0.2,
              ), // Couleur semi-transparente pour l'effet de verre
              child: Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bienvenue sur Bloom buddy',
                      textAlign: TextAlign.center,
                      style: context.txtTheme.headlineSmall!.copyWith(
                        color: context.colorScheme.onPrimary,
                      )
                      ,
                    ).animate()
                    .fade()
                    .slideY(begin: -0.7, duration: 500.ms, curve: Curves.decelerate),
                    SizedBox(height: 10),
                    Text(
                      'Votre compagnon d\'entretien de plantes ',
                      textAlign: TextAlign.center,
                      style: context.txtTheme.bodyLarge!.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    ).animate()
                    .fade()
                    .slideY(begin: -0.7, duration: 500.ms, curve: Curves.decelerate),
                    SizedBox(height: context.screenheight * 0.15),
                    ElevatedButton.icon(
                        icon: Icon(Icons.forward),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => PlantScreen(),
                              ),
                            );
                          },
                          label: Text('Commencer'),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 1500.ms),
                  ],
                ),
              ),
              // Ton contenu à afficher sur l'effet de verre
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}
