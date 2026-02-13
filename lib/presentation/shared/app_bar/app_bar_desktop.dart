import 'package:flutter/material.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';



class AppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDesktop({
    super.key,
    required this.title,
    this.useLeading = false,
    this.useClose = true,
    this.close,
    this.centerTitle = true,
    this.actions,
    this.appBarHeight = 72,
  });

  final String title;
  final bool useLeading;
  final bool useClose;
  final VoidCallback? close;
  final bool centerTitle;
  final List<Widget>? actions;
  final double appBarHeight;

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: useLeading
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            )
          : null,
      toolbarHeight: appBarHeight,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontFamily: AppFonts.eUkraineHead,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.3,
        ),
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: colors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      actions: <Widget>[
        ...(actions ?? []),
        if (useClose)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: close ?? () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close_rounded,
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}
