
import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
//import 'package:definitive_bloom_buddy/features/care_records/data/models/care_record.dart';
import 'package:definitive_bloom_buddy/features/care_records/presentation/state/care_record_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_neumorphism_ultra/flutter_neumorphism_ultra.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CareHistoryWidgets extends ConsumerWidget {
  const CareHistoryWidgets({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Map<String, IconData> careTypeIcons = {
      'watering' : Icons.water_drop_outlined,
      'fertilizing' : Icons.local_florist_outlined,
      'pruning' : Icons.content_cut_outlined
    };

    Map<String, String> careTypefr = {
      'watering' : 'Arrosage',
      'fertilizing' : 'Fertilisation',
      'pruning' : 'Taille'
    };
      
    final asyncCare = ref.watch(careRecordNotiferProvider);
    return SizedBox(
      height: context.screenheight*0.5,
      child: asyncCare.when(data: (data){
        if (data.isEmpty) {
          return Center(child: Text("Aucun soin enregistré"),);
        }else{
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, index){
            
            final care = data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeuContainer(
                height: 55,
                width: double.infinity,
                child: ListTile(
                  leading: Icon(careTypeIcons[care.caretype.name]),
                  title: Text(careTypefr[care.caretype.name]!),
                  subtitle: Text(DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(care.careDate))
                )
                .animate(onPlay: (controller) => controller.repeat(),)
                .shimmer(
                 
                  duration: 1200.ms)
                ,
              ),
            );
          })
          .animate(

          )
          .fadeIn()
          .slideX(
            begin: -0.3,
            duration: 300.ms,
            curve: Curves.easeIn
          )
         
          ;
        }
      }, error: (e, stackTrace){
        return Center(child: Text('Error:$e'),);
      }, loading: ()=> Center(child: CircularProgressIndicator(),))
    );
  }
}