import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    super.key,
    required this.content,
    required this.onPressedNo,
    required this.onPressedYes,
    required this.title,
  });
  final String title;
  final String content;
  final void Function()? onPressedYes;
  final void Function()? onPressedNo;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      title: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info, color: Colors.green),
            Text(
              title,
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: onPressedNo,
                  child: Text(
                    'Non',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.red),
                  ),
                ),
                SizedBox(width: 24),
                ElevatedButton(
                  onPressed: onPressedYes,
                  child: Text(
                    'Oui',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
