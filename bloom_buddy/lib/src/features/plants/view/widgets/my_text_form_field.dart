import 'package:bloom_buddy/src/core/theme/app_borders.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    required this.controller,
    required this.onSavingValue,
    required this.hintText,
    this.isOptional = false,
    this.maxLines,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final void Function(String?)? onSavingValue;
  final String hintText;
  final bool isOptional;
  final int? maxLines;
  final TextInputType? keyboardType;
  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorders.circularSmall,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 2,
            // blurRadius: 7,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.isOptional
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return "Ce champ est obligatoire";
                }
                return null;
              },
        onSaved: widget.onSavingValue,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorders.circularSmall,
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: AppBorders.circularSmall,
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          hintText: widget.hintText,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
