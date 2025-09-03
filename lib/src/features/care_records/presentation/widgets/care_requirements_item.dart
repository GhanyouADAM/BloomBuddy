import 'package:flutter/material.dart';

import '../../domain/entities/care_requirements.dart';

class CareRequirementsItem extends StatelessWidget {
  const CareRequirementsItem({super.key, required this.careRequirements});
  final CareRequirements careRequirements;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lottie.asset(
          //   "assets/animations/Plant, Office, Desk.json",
          //   height: 16,
          //   width: 16,
          // ),
          Icon(Icons.schedule, size: 16, color: Colors.green.shade700),
          SizedBox(width: 6),
          Text(
            careRequirements.careType,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(width: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${careRequirements.careFrequency}j',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
