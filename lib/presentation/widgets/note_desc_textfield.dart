import 'package:flutter/material.dart';
import 'package:viapulsa_test/common/app_colors.dart';

class NoteDescTextField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;

  const NoteDescTextField({
    super.key,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.go,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.grey,
          ),
      maxLines: 1000,
      minLines: 2,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Description',
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.grey,
            ),
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
