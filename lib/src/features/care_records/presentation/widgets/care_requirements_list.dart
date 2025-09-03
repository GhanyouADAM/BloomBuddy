import 'package:bloom_buddy/src/core/notification_service.dart';
import 'package:bloom_buddy/src/features/auth/view/widgets/alert_dialog.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/controller/providers.dart';
import 'package:bloom_buddy/src/features/care_records/presentation/widgets/care_requirements_form.dart';
import 'package:bloom_buddy/src/features/plants/domain/entities/plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/care_requirements.dart';
import 'care_requirements_item.dart';

class CareRequirementsList extends ConsumerStatefulWidget {
  const CareRequirementsList({
    super.key,
    required this.careRequirements,
    required this.plant,
  });
  final Plant plant;
  final List<CareRequirements> careRequirements;

  @override
  ConsumerState<CareRequirementsList> createState() =>
      _CareRequirementsListState();
}

class _CareRequirementsListState extends ConsumerState<CareRequirementsList> {
  final NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationService.initializenotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: widget.careRequirements.length,
      itemBuilder: (ctx, index) {
        final careRequirement = widget.careRequirements[index];
        return InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (ctx) => CareRequirementsForm(
              plant: widget.plant,
              isUpdating: true,
              careRequirements: careRequirement,
            ),
          ),
          onLongPress: () => showDialog(
            context: context,
            builder: (ctx) => MyAlertDialog(
              content: "cette acttion est irreversible, continuer ?",
              onPressedNo: () => Navigator.pop(ctx),
              onPressedYes: () async {
                try {
                  Navigator.of(ctx).pop();
                  await ref
                      .read(supabaseCareRequirementsRepositoryProvider)
                      .deleteCareRequirements(careRequirement.careId);

                  ref.invalidate(careRequirementsStreamProvider);
                  await notificationService.cancelNotification(
                    careRequirement.careId,
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Condition supprimée avec succès'),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erreur lors de la suppression: $e'),
                      ),
                    );
                  }
                }
              },
              title: 'Supprimer',
            ),
          ),
          splashColor: Colors.green,
          borderRadius: BorderRadius.circular(8),
          child: CareRequirementsItem(careRequirements: careRequirement),
        );
      },
    );
  }
}
