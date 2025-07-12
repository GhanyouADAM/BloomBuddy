
import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/screens/ai_plant_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphism_ultra/flutter_neumorphism_ultra.dart';


import '../../datasource/models/plant.dart';

class PlantItemWidget extends StatelessWidget {
  const PlantItemWidget ({super.key, required this.plant});
  final Plant plant;

@override
  Widget build(BuildContext context){
    return NeuContainer(
      color: context.colorScheme.surface,
      height: 70,
      width: double.infinity ,
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AiPlantDetailsScreen(plant: plant)));
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset('assets/images/plants_icons2.png',
          fit: BoxFit.fill,
          ),
        ),
       
        title: Text(plant.plantName,  overflow: TextOverflow.ellipsis,),
        subtitle: Text(plant.plantSpecie,  overflow: TextOverflow.ellipsis,),
        trailing:CircleAvatar(
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.onPrimary,
                      child: IconButton(
                        color: context.colorScheme.onPrimary,
                      onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AiPlantDetailsScreen(plant: plant)));
                      }, icon: Icon(Icons.history_edu_rounded)),
                    ),
        ),
      );
    
    
  }
}
