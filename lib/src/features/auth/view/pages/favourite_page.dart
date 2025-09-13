import 'package:bloom_buddy/src/core/async_widget.dart';
import 'package:bloom_buddy/src/features/plants/view/controllers/plant_controller.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/plant_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final asyncPlantData = ref.watch(likeedPlantsStreamProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Plantes favorites")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: SizedBox(
            child: AsyncValueWidget(
              value: asyncPlantData,
              data: (data) => PlantListWidget(plants: data, isLikePlant: true),
            ),
          ),
        ),
      ),
    );
  }
}
