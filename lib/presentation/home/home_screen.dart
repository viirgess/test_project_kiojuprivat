import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/presentation/shared/adaptive/adaptive_builder.dart';

import 'views/home_desktop_view.dart';
import 'views/home_mobile_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final useDesktop = AdaptiveBuilder.useDesktopLayout(context);
    return useDesktop ? const HomeDesktopView() : const HomeMobileView();
  }
}
