import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project_kiojuprivat/app/di/locator.dart';
import 'package:test_project_kiojuprivat/domain/entities/currency_rate.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rate_history/rate_history_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/shared/adaptive/adaptive_builder.dart';

import 'views/rate_detail_view_desktop.dart';
import 'views/rate_detail_view_mobile.dart';

class RateDetailScreen extends StatelessWidget {
  const RateDetailScreen({super.key, required this.rate});

  final CurrencyRate rate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RateHistoryBloc>(
      create: (_) =>
          locator<RateHistoryBloc>()..requestHistory(currencyCode: rate.code),
      child: AdaptiveBuilder.useDesktopLayout(context)
          ? RateDetailViewDesktop(rate: rate)
          : RateDetailViewMobile(rate: rate),
    );
  }
}
