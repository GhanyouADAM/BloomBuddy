import 'package:bloom_buddy/src/features/care_records/presentation/controller/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_borders.dart';
import '../../../../core/theme/app_spacing.dart';

class CareFilter extends ConsumerWidget {
  const CareFilter({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedFilter = ref.watch(careRequirementsStreamFilter);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChips(
            title: 'Planifiée',
            onSelected: () {
              ref.read(careRequirementsStreamFilter.notifier).state =
                  'Scheduled';
            },
            isSelected: selectedFilter == 'Scheduled',
            color: Colors.green,
          ),
          FilterChips(
            title: 'A faire aujourd\'hui',
            onSelected: () {
              ref.read(careRequirementsStreamFilter.notifier).state = 'due';
            },
            isSelected: selectedFilter == 'due',
            color: Colors.deepOrange,
          ),
          FilterChips(
            title: 'En retard',
            onSelected: () {
              ref.read(careRequirementsStreamFilter.notifier).state = 'late';
            },
            isSelected: selectedFilter == 'late',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class FilterChips extends StatelessWidget {
  const FilterChips({
    super.key,
    required this.title,
    required this.onSelected,
    required this.isSelected,
    required this.color,
  });
  final String title;
  final void Function() onSelected;
  final Color color;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: EdgeInsets.only(right: AppSpacing.sm),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppBorders.circularLarge,
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_list,
              size: 16,
              color: color.withValues(alpha: 0.7),
            ),
            SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color.withValues(alpha: isSelected ? 1 : 0.5),
              ),
            ),
            SizedBox(width: AppSpacing.xs),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isSelected ? 1 : 0.5),
                borderRadius: AppBorders.circularSmall,
              ),
              child: Icon(
                isSelected ? Icons.check : null,
                size: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
