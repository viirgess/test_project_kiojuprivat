import 'package:flutter/material.dart';

class DesktopViewLimiter extends StatelessWidget {
  const DesktopViewLimiter({
    super.key,
    required this.child,
    this.desktopLayout = true,
    this.maxWidth = 640,
    this.margin,
  });

  final Widget child;
  final bool desktopLayout;
  final double maxWidth;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    if (!desktopLayout) {
      return Padding(padding: margin ?? EdgeInsets.zero, child: child);
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: margin ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}
