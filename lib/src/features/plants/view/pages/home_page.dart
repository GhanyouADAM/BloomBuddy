import 'package:bloom_buddy/src/core/async_widget.dart';
import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/features/auth/view/controller/auth_controller.dart';
import 'package:bloom_buddy/src/features/auth/view/widgets/alert_dialog.dart';
import 'package:bloom_buddy/src/features/plants/view/controllers/plant_controller.dart';
import 'package:bloom_buddy/src/features/plants/view/providers/plant_filter_provider.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/plant_form.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/plant_list_widget.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Future<void> _signOut() async {
    try {
      await ref.read(authRepositoryProvider).signOut();
      ref.invalidate(authStateChangesProvider);
    } catch (e) {
      if (mounted) _showSnackbar("Erreur lors de la deconnexion: $e");
    }
  }

  // Methode utilitaire pour les Snacbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showModalToAddPlant() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>
          Padding(padding: const EdgeInsets.all(8.0), child: PlantForm()),
    );
  }

  // void _onCancel(BuildContext ctx) => Navigator.of(ctx).pop();
  @override
  Widget build(BuildContext context) {
    final plants = ref.watch(plantStreamProvider);
    final userData = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: AsyncValueWidget(
          value: userData,
          data: (data) => Text(
            "Hi, ${data!.firstName}"
            " ${data.lastName}",
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => MyAlertDialog(
                  content:
                      'vous aller être rediriger vers la page de connexion',
                  onPressedNo: () => Navigator.of(ctx).pop(),
                  onPressedYes: _signOut,
                  title: 'Se deconnecter',
                ),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                ),
                onChanged: (value) => ref.read(queryProvider.notifier).state =
                    value.toLowerCase(),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                hintText: 'Rechercher une plante...',
                hintStyle: WidgetStatePropertyAll(
                  Theme.of(context).textTheme.bodyMedium,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search, size: 27),
                ),
              ),
            ),
            SizedBox(height: 32),

            Builder(
              builder: (context) {
                final selectedIndex = ref.watch(plantFilterIndexProvider);
                return ChipList(
                  showCheckmark: false,
                  elevation: 3,
                  extraOnToggle: (index) {
                    ref.read(plantFilterIndexProvider.notifier).state = index;
                  },

                  activeBgColorList: [Colors.green],
                  activeTextColorList: [Colors.white],
                  inactiveTextColorList: [Colors.green],
                  inactiveBgColorList: [Colors.white],
                  inactiveBorderColorList: [Colors.green],
                  listOfChipNames: ['Dates d\'ajout', 'Noms', 'Espèces'],
                  listOfChipIndicesCurrentlySelected: [selectedIndex],
                );
              },
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              height: 360,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
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

              child: plants.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(child: Text("Aucune plante"));
                  }
                  return PlantListWidget(plants: data);
                },
                error: (e, s) => Center(
                  child: Text("Oops something went wrong: \\${e.toString()}"),
                ),
                loading: () => Center(child: LoadingWidget(height: 80)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: _showModalToAddPlant,
        child: Icon(Icons.add),
      ),
    );
  }
}
