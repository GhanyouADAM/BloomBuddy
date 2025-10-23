import 'package:bloom_buddy/src/core/loading_widget.dart';
import 'package:bloom_buddy/src/core/notification_service.dart';
import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:bloom_buddy/src/core/theme/app_spacing.dart';
import 'package:bloom_buddy/src/features/care_records/domain/entities/care_requirements.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/controller/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../plants/domain/entities/plant.dart';
import '../../../plants/view/widgets/my_text_form_field.dart';

class CareRequirementsForm extends ConsumerStatefulWidget {
  const CareRequirementsForm({
    super.key,
    required this.plant,
    this.isUpdating = false,
    this.careRequirements,
  });
  final Plant plant;
  final bool isUpdating;
  final CareRequirements? careRequirements;
  @override
  ConsumerState<CareRequirementsForm> createState() =>
      _CareRequirementsFormState();
}

class _CareRequirementsFormState extends ConsumerState<CareRequirementsForm> {
  final _formKey = GlobalKey<FormState>();
  final _careTypeController = TextEditingController();
  final _careFrequencyController = TextEditingController();
  bool _isLoading = false;
  CareRequirements? careRequirements;
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    // notificationService.initializenotifications();
  }

  @override
  void dispose() {
    _careTypeController.dispose();
    _careFrequencyController.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    if (widget.isUpdating && widget.careRequirements != null) {
      _careTypeController.text = widget.careRequirements!.careType;
      _careFrequencyController.text = widget.careRequirements!.careFrequency
          .toString();
      careRequirements = widget.careRequirements;
    }
  }

  void onSubmitCareType(
    String? value,
  ) {} // Non utilisé avec validation manuelle
  void onSubmitCareFrequency(
    String? value,
  ) {} // Non utilisé avec validation manuelle

  Future<void> _finalSubmit() async {
    // Validation manuelle puisque les champs sont dans AlertDialog
    if (_careTypeController.text.trim().isEmpty) {
      _showSnackbar("Veuillez saisir le type de soin");
      return;
    }

    final careFrequency = int.tryParse(_careFrequencyController.text.trim());
    if (careFrequency == null || careFrequency <= 0) {
      _showSnackbar("Veuillez saisir une fréquence valide (nombre positif)");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (!widget.isUpdating) {
        debugPrint("Avant createCareRequirements");
        final careRequirement = await ref
            .read(supabaseCareRequirementsRepositoryProvider)
            .createCareRequirements(
              widget.plant.plantId,
              _careTypeController.text.trim(),
              careFrequency,
              status: 'Scheduled',
              lastCareDate: DateTime.now(),
              nextCareDate: DateTime.now().add(Duration(days: careFrequency)),
            );

        try {
          await notificationService.advancedScheduledNotifications(
            careId: careRequirement.careId,
            title: "Rappel de soins pour ${widget.plant.plantName} ",
            body:
                "vous avez un ${careRequirement.careType} a faire aujourd'hui",
            interval: careRequirement.careFrequency,
          );
        } catch (e) {
          debugPrint("Erreur lors du scheduling: $e");
        }
        await notificationService.showInstantNotifications(
          title: 'Bloom buddy',
          body: "Nouvelle ajout de conditions de soins",
        );

        if (mounted) {
          _showSnackbar("Condition de soin ajoutée avec succès");
          Navigator.of(context).pop();
        }
      } else {
        careRequirements = careRequirements!.copyWith(
          careFrequency: careFrequency,
          careType: _careTypeController.text.trim(),
        );
        await ref
            .read(supabaseCareRequirementsRepositoryProvider)
            .updateCareRequirements(careRequirements!);

        if (mounted) {
          _showSnackbar("Condition de soin modifié avec succès");
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (mounted) {
        !widget.isUpdating
            ? _showSnackbar("Erreur lors de la création: $e")
            : _showSnackbar("Erreur lors de la modification: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_florist, color: Colors.green, size: 32),
            const SizedBox(height: AppSpacing.sm),
            Text(
              !widget.isUpdating
                  ? 'Nouvelle condition de soin'
                  : 'Modification de la condition de soin',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Pour ${widget.plant.plantName}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14,
                color: Colors.green.shade600,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Précisez le type et la fréquence du soin',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Ex: Arrosage tous les 3 jours',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                MyTextFormField(
                  controller: _careTypeController,
                  hintText: 'Type de soin (ex: Arrosage)',
                  onSavingValue: onSubmitCareType,
                ),
                SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        controller: _careFrequencyController,
                        hintText: 'Fréquence en jours',
                        keyboardType: TextInputType.number,
                        onSavingValue: onSubmitCareFrequency,
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      'jours',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          width: double.infinity,
          child: Row(
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade600,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: Text('Annuler'),
              ),
              SizedBox(width: AppSpacing.md),
              ElevatedButton(
                onPressed: _isLoading ? null : _finalSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorders.circularSmall,
                  ),
                ),
                child: _isLoading
                    ? Center(child: LoadingWidget())
                    : Text(!widget.isUpdating ? 'Ajouter' : 'Modifier'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
