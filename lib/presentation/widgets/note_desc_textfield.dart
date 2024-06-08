import 'package:flutter/material.dart';
import 'package:viapulsa_test/common/app_colors.dart';

class NoteDescTextField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;

  const NoteDescTextField({
    super.key,
    this.initialValue,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
