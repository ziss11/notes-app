import 'package:flutter/material.dart';
import 'package:viapulsa_test/common/app_colors.dart';

class NoteTitleTextField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;

  const NoteTitleTextField({
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
      textInputAction: TextInputAction.next,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
            ),
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
