import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/widgets/plant_details/image_title.dart';
import 'package:flutter/material.dart';


import '../../datasource/models/plant.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key, required this.plant});

  final Plant plant;

@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        title: Text('Details de la plante'),),
      body: Column(
        
        
        mainAxisSize: MainAxisSize.min,
        children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
           child: TitleCard(plant: plant)
         )

        ],
      ),
       floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary
        ,onPressed: (){}, label: Text('Proceder au soin'), icon: Icon(Icons.add),),
    );
  }
}