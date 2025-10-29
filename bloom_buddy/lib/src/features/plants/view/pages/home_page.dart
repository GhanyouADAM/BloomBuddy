import 'package:bloom_buddy/src/core/async_widget.dart';
import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/auth/domain/entities/user.dart';
import 'package:bloom_buddy/src/features/auth/view/controller/auth_controller.dart';
import 'package:bloom_buddy/src/features/auth/view/widgets/alert_dialog.dart';
import 'package:bloom_buddy/src/features/plants/domain/entities/plant.dart';
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
      appBar: buildAppBar(context),
      drawer: buildDrawer(userData, context),
      body: SafeArea(
        child: SingleChildScrollView(child: mainBody(context, plants)),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: _showModalToAddPlant,
        child: Icon(Icons.add),
      ),
    );
  }

  //drawer
  Drawer buildDrawer(AsyncValue<AppUser?> userData, BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, size: 32, color: Colors.white),
                ),
                SizedBox(width: 16),
                // Contrainte de largeur pour éviter overflow
                Expanded(
                  child: AsyncValueWidget(
                    value: userData,
                    data: (user) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user!.firstName} ${user.lastName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            user.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.green, fontSize: 11),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('A propos'),
            onTap: () {
              Navigator.of(context).pop();
              showAboutDialog(
                context: context,
                applicationName: 'Bloom Buddy',
                applicationVersion: '1.1.0',

                applicationIcon: Icon(Icons.local_florist),
                applicationLegalese:
                    '© 2025 Bloom Buddy. Tous droits réservés. by Abdoul-Ghanyou ADAM',
                children: [
                  Text(
                    'Bloom Buddy est une application dédiée aux passionnés de plantes, les aidant à prendre soin de leurs compagnons verts grâce à des rappels',
                  ),
                ],
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Se deconnecter'),
            onTap: () {
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
          ),
        ],
      ),
    );
  }

  void _showTutorialDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: AppBorders.circularLarge),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppBorders.radiusLarge),
              topRight: Radius.circular(AppBorders.radiusLarge),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info, color: Colors.green),
              Text(
                'Tutoriel',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
            ],
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bienvenue sur Bloom Buddy.',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Comment ça marche ?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Vous avez trois sections : L\'accueil, les soins, et les favoris',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Dans l\'accueil vous avez la possibilité d\'ajouter vos plantes avec le bouton + , une fois créée elle apparaîtra dans l\'accueil de là vous pouvez:',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Padding(
                  padding: EdgeInsets.only(left: AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '- cliquer sur détails pour aller dans les détails (on y reviendra)',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '- Modifier la plante en cliquant sur l\'image animée',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '- supprimer la plante en swipant vers la gauche',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'une fois une plante créée vous allez dans les détails pour ajouter les conditions de soins en appuyant sur le bouton + dans la section détails de la plante. les conditions ont un nom et un intervalle, par ex si ajouter comme condition Arrosage tout les 1j vous aurez des rappels pour cette plante tout les 1 jours !',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  '_les rappels ne se reprogramment pas automatiquement, il faut que vous confirmer manuellement après le rappel pour déclencher un autre rappel sinon ce dernier rentre dans la section des retards',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  '- et pour finir vous avez les favoris',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Dans l\'écran détail vous avez la possibilité de supprimer des conditions de soins en maintenant appuyé dessus.',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Bon jardinage !',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    'Fermer',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Appbar
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          icon: Icon(Icons.info, color: Colors.black),
          onPressed: _showTutorialDialog,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(170),
        child: Column(
          children: [
            Text(
              "Bloom Buddy",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Prenez soin de vos plantes',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: SearchBar(
                padding: WidgetStatePropertyAll(EdgeInsets.all(AppSpacing.sm)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: AppBorders.circularMedium,
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
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Icon(Icons.search, size: 27),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF81C784), Color(0xFFE8F5E9), Colors.white],
          ),
        ),
      ),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //Main content of the body
  Column mainBody(BuildContext context, AsyncValue<List<Plant>> plants) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
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
        SizedBox(height: AppSpacing.xl),
        Container(
          padding: EdgeInsets.all(AppSpacing.md),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppBorders.radiusLarge),
              topRight: Radius.circular(AppBorders.radiusLarge),
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
    );
  }
}
