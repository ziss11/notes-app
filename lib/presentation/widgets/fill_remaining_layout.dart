import 'package:flutter/material.dart';

class FillRemainingLayout extends StatelessWidget {
  final Widget child;

  const FillRemainingLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(child: child),
      ],
    );
  }
}
