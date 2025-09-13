import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/auth/view/controller/auth_controller.dart';
import 'package:bloom_buddy/src/features/plants/domain/entities/plant.dart';
import 'package:bloom_buddy/src/features/plants/view/controllers/plant_controller.dart';
import 'package:bloom_buddy/src/features/plants/view/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantForm extends ConsumerStatefulWidget {
  const PlantForm({super.key, this.plantToUpdate, this.isUpating = false});

  final Plant? plantToUpdate;
  final bool isUpating;
  @override
  ConsumerState<PlantForm> createState() => _AddFormPlantState();
}

class _AddFormPlantState extends ConsumerState<PlantForm> {
  final TextEditingController _plantNameController = TextEditingController();
  final TextEditingController _plantSpeciesController = TextEditingController();
  final TextEditingController _plantDescriptionController =
      TextEditingController();
  String plantName = "";
  String plantSpecies = "";
  String? plantDescription = "";
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _plantNameController.dispose();
    _plantSpeciesController.dispose();
    _plantDescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    superCharging();
    super.initState();
  }

  //------- en cas d'update precharge les champs avec les données de la plante sélèctionner -----
  void superCharging() {
    if (widget.isUpating && widget.plantToUpdate != null) {
      final plant = widget.plantToUpdate!;
      _plantNameController.text = plant.plantName;
      _plantSpeciesController.text = plant.plantSpecie;
      _plantDescriptionController.text = plant.plantDescription ?? "";
    }
  }

  // ----- textFields validation method ---
  _onSubmitPlantName(String? valueN) => plantName = valueN!;
  _onSubmitPlantSpecies(String? valueS) => plantSpecies = valueS!;
  _onSubmitPlantDescription(String? valueD) => plantDescription = valueD;

  //-----Add/update -----
  Future<void> _finalSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final user = ref.watch(authStateChangesProvider).asData?.value;
        if (user == null) return;
        //------- updating -------------
        if (widget.isUpating && widget.plantToUpdate != null) {
          final plant = widget.plantToUpdate!.copyWith(
            updatedAt: DateTime.now(),
            plantDescription: plantDescription,
            plantName: plantName,
            plantSpecie: plantSpecies,
          );

          await ref.read(supabasePlantRepository).updatePlant(plant);
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Plante modifiée")));
            Navigator.of(context).pop();
          }
        } else {
          //-----------adding-----
          await ref
              .read(supabasePlantRepository)
              .createPlant(plantName, plantSpecies, plantDescription);
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Plante ajoutée")));
            Navigator.of(context).pop();
          }

          // widget.onCancel;
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.isUpating
                    ? "Erreur lors de la modification: $e"
                    : "Erreur lors de l'ajout: $e",
              ),
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_florist, color: Colors.green),
              SizedBox(height: AppSpacing.sm),
              Center(
                child: Text(
                  widget.isUpating
                      ? "Modifier une plante"
                      : "Ajouter une plante",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              SizedBox(height: AppSpacing.lg),
              MyTextFormField(
                controller: _plantNameController,
                onSavingValue: _onSubmitPlantName,
                hintText: 'Nom de la plante',
              ),
              SizedBox(height: AppSpacing.sm),
              MyTextFormField(
                controller: _plantSpeciesController,
                onSavingValue: _onSubmitPlantSpecies,
                hintText: "Espece de la plante",
              ),
              SizedBox(height: AppSpacing.sm),
              MyTextFormField(
                controller: _plantDescriptionController,
                onSavingValue: _onSubmitPlantDescription,
                isOptional: true,
                maxLines: 4,
                hintText: "Description de la plante(Optionel)",
              ),
              SizedBox(height: AppSpacing.xxl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isLoading ? null : _finalSubmit,
                  child: _isLoading
                      ? Center(child: LoadingWidget())
                      : Text(widget.isUpating ? "Modifier" : "Ajouter"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
