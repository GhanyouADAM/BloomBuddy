import 'package:definitive_bloom_buddy/core/utils/context_extension.dart';
//import 'package:definitive_bloom_buddy/features/plants/presentation/state/plant_provider.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class AnimatedFilterChips extends ConsumerStatefulWidget {
  const AnimatedFilterChips({super.key});
  @override
  ConsumerState<AnimatedFilterChips> createState() => _AnimatedFilterChipsState();
}

class _AnimatedFilterChipsState extends ConsumerState<AnimatedFilterChips> {

  final List<Map<String, dynamic>> filters = [
    {'icon': Icons.park, 'label': 'Plantes'},
     {'icon': Icons.announcement_rounded, 'label': 'Soins requis'},
    {'icon': Icons.favorite, 'label': 'Favoris'},
  ];
  
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(indexProvider);
    
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [
           context.colorScheme.primaryContainer.withValues(
                              alpha: 0.5,
                            ),
                            context.colorScheme.secondaryContainer.withValues(
                              alpha: 0.5,
                            ),
                            context.colorScheme.tertiaryContainer.withValues(
                              alpha: 0.5,
                            ),
        ])
      ),
      height: 50,
      width: double.infinity,
      child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: List.generate(
    filters.length,
    (index) => GestureDetector(
      onTap: () {
        ref.read(indexProvider.notifier).state = index;
        switch (index) {
           case 2:
            ref.read(plantFilterProvider.notifier).state = PlantFilter.favorites;
          case 1:
            ref.read(plantFilterProvider.notifier).state = PlantFilter.urgent;
           
          case 0:
            ref.read(plantFilterProvider.notifier).state = PlantFilter.plants;
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: selectedIndex == index ? 16.0 : 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? context.colorScheme.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: selectedIndex == index
                        ? Colors.white
                        : Colors.white,
                    child: Icon(
                      filters[index]['icon'],
                      size: 18,
                      color: selectedIndex == index
                          ? context.colorScheme.primary
                          : Colors.grey.shade700,
                    ),
                  ),
                  if (selectedIndex == index)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: selectedIndex == index ? 8.0 : 0.0,
                    ),
                  if (selectedIndex == index)
                    AnimatedOpacity(
                      opacity: selectedIndex == index ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        filters[index]['label'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Ajoute un badge uniquement pour l'index 1 (Soins requis)
          
            // if (index == 1 && async.hasValue )
            // if(async.value != null)
            // if(async.value!.isNotEmpty)
            
            //   Positioned(
            //     top: -5,
            //     right: -5,
            //     child: Container(
            //       padding: EdgeInsets.all(4),
            //       decoration: BoxDecoration(
            //         color: Colors.red,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Text(
            //         '!',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 10,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    ),
  ),
),
    );
  }
}