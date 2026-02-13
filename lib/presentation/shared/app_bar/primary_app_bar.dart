import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';



class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      automaticallyImplyLeading: false,
      leading: (showBackButton && canPop)
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            )
          : null,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: AppFonts.eUkraineHead,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.3,
          ),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      actions: actions,
    );
  }
}
