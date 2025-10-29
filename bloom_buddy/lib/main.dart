import 'package:bloom_buddy/src/core/notification_service.dart';
import 'package:bloom_buddy/src/core/router.dart';
import 'package:bloom_buddy/src/core/supabase_credentials.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Supprimez cette ligne
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisez le service de notification ici
  await NotificationService().initializenotifications();

  await Supabase.initialize(
    anonKey: SupabaseCredentials.supabaseAnonKey,
    url: SupabaseCredentials.supabaseUrl,
  );
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
      title: 'Bloom buddy',
    );
  }
}
