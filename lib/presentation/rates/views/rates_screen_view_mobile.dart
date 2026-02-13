import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rates/rates_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rate_card.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_error_body.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_no_results.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_search_bar.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_updated_at_header.dart';
import 'package:test_project_kiojuprivat/presentation/shared/app_bar/primary_app_bar.dart';
import 'package:test_project_kiojuprivat/app/helper/currency_search_helper.dart';

class RatesMobileView extends StatefulWidget {
  const RatesMobileView({super.key});

  @override
  State<RatesMobileView> createState() => _RatesMobileViewState();
}

class _RatesMobileViewState extends State<RatesMobileView> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() => _query = value);
  }

  @override
  Widget build(BuildContext context) {
    final refreshButton = IconButton(
      onPressed: () => context.read<RatesBloc>().refreshRates(),
      icon: const Icon(Icons.refresh_rounded),
      tooltip: context.l10n.retry,
    );

    return Scaffold(
      appBar: PrimaryAppBar(
        title: context.l10n.ratesTitle,
        actions: <Widget>[refreshButton],
      ),
      body: BlocBuilder<RatesBloc, RatesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isError) {
            return const RatesErrorBody();
          }
          if (state.isReady) {
            final allRates = state.asReady.rates;
            if (allRates.isEmpty) {
              return Center(child: Text(context.l10n.loading));
            }
            final filteredRates = CurrencySearchHelper.filter(
              context,
              allRates,
              _query,
            );
            final updatedAt = allRates.first.exchangedAt;

            return RefreshIndicator(
              onRefresh: () async => context.read<RatesBloc>().refreshRates(),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: filteredRates.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RatesUpdatedAtHeader(
                          updatedAt: updatedAt,
                        ),
                        RatesSearchBar(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          query: _query,
                        ),
                      ],
                    );
                  }
                  if (index == 1 && filteredRates.isEmpty) {
                    return const RatesNoResults();
                  }
                  if (index - 1 >= filteredRates.length) {
                    return const SizedBox.shrink();
                  }
                  return RateCard(
                    rate: filteredRates[index - 1],
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
