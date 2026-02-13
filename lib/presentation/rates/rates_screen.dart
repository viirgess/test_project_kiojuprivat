import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project_kiojuprivat/app/di/locator.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rates/rates_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/shared/adaptive/adaptive_builder.dart';

import 'views/rates_screen_view_desktop.dart';
import 'views/rates_screen_view_mobile.dart';

class RatesScreen extends StatelessWidget {
  const RatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RatesBloc>(
      create: (_) => locator<RatesBloc>()..requestRates(),
      child: AdaptiveBuilder.useDesktopLayout(context)
          ? const RatesDesktopView()
          : const RatesMobileView(),
    );
  }
}
