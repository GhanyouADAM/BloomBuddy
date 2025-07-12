import 'package:definitive_bloom_buddy/features/plants/presentation/screens/on_boarding_page.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/screens/plant_screen.dart';
import 'package:definitive_bloom_buddy/features/plants/presentation/state/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

final theme = ThemeData().copyWith(
  textTheme: GoogleFonts.poppinsTextTheme(),
  colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 148, 99))
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);

  runApp(ProviderScope(child: const BloomBuddyApp()));
}

class BloomBuddyApp extends  ConsumerWidget {
  const BloomBuddyApp({super.key});


@override
  Widget build(context, ref) {
    final firstScreenAsync =  ref.watch(isFirstRunProvider);
    return MaterialApp(
      
      home : firstScreenAsync.when(data: (isFirstRun){
        return isFirstRun ? const OnBoardingPage() : const PlantScreen();
      },  loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('error: $err')),),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}