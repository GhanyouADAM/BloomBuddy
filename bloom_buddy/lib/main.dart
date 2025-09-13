import 'package:bloom_buddy/src/core/notification_service.dart';
import 'package:bloom_buddy/src/core/router.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Supprimez cette ligne
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supprimez cette ligne : final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const String supabaseUrl = 'https://kfbegmyrdpzwqykppkcn.supabase.co';
const String supabaseAnonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtmYmVnbXlyZHB6d3F5a3Bwa2NuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMyMTEzMzYsImV4cCI6MjA2ODc4NzMzNn0.oco51KkflnrJnF5nsUP72E3DeJBHjf3fm-vXJyir7SE";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisez le service de notification ici
  await NotificationService().initializenotifications();

  await Supabase.initialize(anonKey: supabaseAnonKey, url: supabaseUrl);
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(textTheme: GoogleFonts.poppinsTextTheme()),
      title: 'Bloom budy',
    );
  }
}
