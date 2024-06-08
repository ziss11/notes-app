import 'package:flutter/material.dart';
import 'package:viapulsa_test/common/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final double? height;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String value)? onChanged;

  const AppTextField({
    super.key,
    this.height = 56,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: AppColors.darkGrey,
          hintText: hintText ?? 'Search',
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
              ),
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
