import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double kDesktopBreakpoint = 600;

class AdaptiveBuilder extends StatelessWidget {
  const AdaptiveBuilder({
    super.key,
    required this.mobileBuilder,
    required this.desktopBuilder,
  });

  final WidgetBuilder mobileBuilder;
  final WidgetBuilder desktopBuilder;

  static bool useDesktopLayout(BuildContext context) {
    if (!kIsWeb) return false;
    return MediaQuery.sizeOf(context).width >= kDesktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= kDesktopBreakpoint;
  }

  @override
  Widget build(BuildContext context) {
    if (useDesktopLayout(context)) {
      return desktopBuilder(context);
    }
    return mobileBuilder(context);
  }
}
