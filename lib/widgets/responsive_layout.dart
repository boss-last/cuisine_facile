import 'package:flutter/material.dart';

/// Widget réutilisable n°4 (bonus) – Layout responsive
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final double breakpoint;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.breakpoint = 600,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}

/// Helper pour déterminer si on est sur tablette
bool isTablet(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= 600;
}

int gridCrossAxisCount(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width >= 1200) return 4;
  if (width >= 800) return 3;
  if (width >= 600) return 2;
  return 1;
}
