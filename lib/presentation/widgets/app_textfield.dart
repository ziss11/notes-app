import 'package:flutter/material.dart';
import 'package:viapulsa_test/common/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final double? height;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final FocusNode? focusNode;
  final void Function(String value)? onChanged;

  const AppTextField({
    super.key,
    this.height = 40,
    this.hintText,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        focusNode: focusNode,
        enabled: enabled,
        controller: controller,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.darkGrey,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
              ),
          contentPadding: EdgeInsets.zero,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
