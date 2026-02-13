import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/presentation/shared/app_bar/primary_app_bar.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PrimaryAppBar(title: title, showBackButton: false);
  }
}
