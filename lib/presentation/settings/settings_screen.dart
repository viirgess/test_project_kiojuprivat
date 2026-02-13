import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/presentation/shared/adaptive/adaptive_builder.dart';


import 'views/settings_view_desktop.dart';
import 'views/settings_view_mobile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final useDesktop = AdaptiveBuilder.useDesktopLayout(context);
    return useDesktop ? const SettingsViewDesktop() : const SettingsViewMobile();
  }
}
