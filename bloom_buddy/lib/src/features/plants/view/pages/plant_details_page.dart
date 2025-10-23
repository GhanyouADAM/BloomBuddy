import 'dart:ui';

import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/controller/providers.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/widgets/care_requirements_list.dart';
import 'package:bloom_buddy/src/features/plants/domain/entities/plant.dart';
import 'package:bloom_buddy/src/features/plants/view/controllers/plant_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

import '../../../care_records/presentation/widgets/care_requirements_form.dart';

class PlantDetailsPage extends ConsumerStatefulWidget {
  const PlantDetailsPage({super.key, required this.plant});
  final Plant plant;

  @override
  ConsumerState<PlantDetailsPage> createState() => _PlantDetailsPageState();
}

class _PlantDetailsPageState extends ConsumerState<PlantDetailsPage> {
  Future<void> _liking() async {
    final likedPlant = widget.plant.copyWith(isLiked: !widget.plant.isLiked);
    try {
      await ref.read(supabasePlantRepository).updatePlant(likedPlant);
      // Mettre à jour l'état local immédiatement
      setState(() {
        widget.plant.isLiked = !widget.plant.isLiked;
      });
      if (mounted) {
        toastification.show(
          context: context,
          style: ToastificationStyle.flat,
          closeOnClick: true,
          autoCloseDuration: Duration(seconds: 3),
          // icon: Icon(Icons.info),
          title: Text(
            widget.plant.isLiked
                ? "${widget.plant.plantName} ajoutée aux favoris"
                : "${widget.plant.plantName} retirée des favoris",
          ),
        );
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(milliseconds: 1000),
      //     backgroundColor: Colors.green,
      //     content: Text(
      //       widget.plant.isLiked
      //           ? "${widget.plant.plantName} ajoutée aux favoris"
      //           : "${widget.plant.plantName} retirée des favoris",
      //     ),
      //   ),
      // );
    } catch (e) {
      if (kDebugMode) print("something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    final careRequirements = ref.watch(
      careRequirementsStreamProvider(widget.plant.plantId),
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Détails plante"),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 28,
          color: Colors.black87,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SECTION IMAGE EN HAUT - CENTRÉE
            SizedBox(
              height: AppSpacing.xxl * 7,
              width: double.infinity,
              child: Center(
                child: Hero(
                  tag:
                      "plant_image_${widget.plant.plantId}", // Même tag que dans plant_item
                  child: ClipRRect(
                    borderRadius: AppBorders.circularLarge,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: AppBorders.circularLarge,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: AppBorders.circularLarge,
                          child: Lottie.asset(
                            'assets/animations/Lotus Flower.json',
                            repeat: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // CONTAINER EN BAS AVEC BORDS ARRONDIS
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppBorders.radiusLarge),
                  topRight: Radius.circular(AppBorders.radiusLarge),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre de la plante
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.plant.plantName,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                        ),
                        SizedBox(width: AppSpacing.lg),
                        IconButton(
                          onPressed: _liking,
                          icon: Icon(
                            widget.plant.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.sm),

                    // Espèce
                    Text(
                      widget.plant.plantSpecie,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),

                    // Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          widget.plant.plantDescription ?? "Aucune description",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                        ),
                        SizedBox(height: AppSpacing.xxl),
                        careRequirements.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return Center(
                                child: Text(
                                  "Aucune condition de soin pour cette plante.",
                                ),
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Conditions de soin",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  SizedBox(height: AppSpacing.md),
                                  SizedBox(
                                    height: AppSpacing.xxl,
                                    child: CareRequirementsList(
                                      careRequirements: data,
                                      plant: widget.plant,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                          error: (e, s) => Center(child: Text(e.toString())),
                          loading: () => Center(child: LoadingWidget()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CareRequirementsForm(plant: widget.plant),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
