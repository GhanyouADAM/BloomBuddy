import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../features/auth/view/controller/auth_controller.dart';
import '../features/care_records/presentation/pages/care_page.dart';
import '../features/plants/view/pages/favourite_page.dart';
import '../features/auth/view/pages/login_page.dart';
import '../features/auth/view/pages/register_page.dart';
import '../features/auth/view/pages/settings.dart';
import '../features/plants/view/pages/home_page.dart';

// GlobalKeys statiques pour éviter les duplications
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellHomeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _shellCareNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'care');
final GlobalKey<NavigatorState> _shellFavouriteNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'favourite');
final GlobalKey<NavigatorState> _shellSettingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');

final routerProvider = Provider<GoRouter>((ref) {
  final authStateChanges = ref.watch(authStateChangesProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/login",
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final isAuthenticated = authStateChanges.asData?.value != null;
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/login/register';

      if (!isAuthenticated) {
        // Permet l'accès aux pages d'auth (login et register)
        return (isLoggingIn || isRegistering) ? null : "/login";
      }
      if (isLoggingIn || isRegistering) {
        // Redirige vers home si déjà connecté
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScreenMolder(navigationShell: navigationShell),
        branches: [
          // ------- Home -------
          StatefulShellBranch(
            navigatorKey: _shellHomeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),

          // ------- Care -------
          StatefulShellBranch(
            navigatorKey: _shellCareNavigatorKey,
            routes: [
              GoRoute(
                path: '/care',
                builder: (context, state) => const CarePage(),
              ),
            ],
          ),

          // ------- favourite -------
          StatefulShellBranch(
            navigatorKey: _shellFavouriteNavigatorKey,
            routes: [
              GoRoute(
                path: '/favourite',
                builder: (context, state) => const FavouritePage(),
              ),
            ],
          ),

          // ------- settings -------
          StatefulShellBranch(
            navigatorKey: _shellSettingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const Settings(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class ScreenMolder extends StatefulWidget {
  const ScreenMolder({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  State<ScreenMolder> createState() => _ScreenMolderState();
}

class _ScreenMolderState extends State<ScreenMolder> {
  int previousIndex = 0;
  int get currentIndex => widget.navigationShell.currentIndex;
  @override
  Widget build(BuildContext context) {
    // Détecte la direction
    final int direction = currentIndex > previousIndex
        ? 1
        : (currentIndex < previousIndex ? -1 : 0);

    final child = widget.navigationShell;

    Widget animatedChild = child
        .animate(key: ValueKey(currentIndex))
        .slide(
          begin: Offset(direction.toDouble(), 0),
          end: Offset(0, 0),
          duration: 500.ms,
          curve: Curves.easeInOut,
        )
        .fadeIn(duration: 500.ms);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: 400.ms,
        transitionBuilder: (Widget child, Animation<double> animation) {
          // On utilise le widget animé
          return animatedChild;
        },
        child: child,
      ),
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (value) {
          setState(() {
            previousIndex = currentIndex;
          });
          widget.navigationShell.goBranch(
            value,
            initialLocation: value == currentIndex,
          );
        },
        tabs: [
          GButton(
            icon: LineIcons.home,
            text: 'Accueil',
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          GButton(
            icon: LineIcons.bug,
            text: 'Soins',
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          GButton(
            icon: LineIcons.heart,
            text: "favoris",
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
          GButton(
            icon: LineIcons.user,
            text: 'Profile',
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
