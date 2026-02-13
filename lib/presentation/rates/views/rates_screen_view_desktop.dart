import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_project_kiojuprivat/app/extensions/l10n_extension.dart';
import 'package:test_project_kiojuprivat/presentation/blocs/rates/rates_bloc.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rate_card.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_error_body.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_no_results.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_search_bar.dart';
import 'package:test_project_kiojuprivat/presentation/rates/widgets/rates_updated_at_header.dart';
import 'package:test_project_kiojuprivat/app/theme/app_fonts.dart';
import 'package:test_project_kiojuprivat/app/helper/currency_search_helper.dart';

class RatesDesktopView extends StatefulWidget {
  const RatesDesktopView({super.key});

  @override
  State<RatesDesktopView> createState() => _RatesDesktopViewState();
}

class _RatesDesktopViewState extends State<RatesDesktopView> {
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
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 28, 32, 0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    context.l10n.ratesTitle,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontFamily: AppFonts.eUkraineHead,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => context.read<RatesBloc>().refreshRates(),
                  icon: const Icon(Icons.refresh_rounded),
                  tooltip: context.l10n.retry,
                ) ,
              ],
            ),
          ),    
          Expanded(
            child: BlocBuilder<RatesBloc, RatesState>(
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

                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RatesUpdatedAtHeader(updatedAt: updatedAt),
                              RatesSearchBar(
                                controller: _searchController,
                                onChanged: _onSearchChanged,
                                query: _query,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (filteredRates.isEmpty)
                        SliverToBoxAdapter(child: const RatesNoResults())
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 320,
                                  mainAxisExtent: 72,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  RateCard(rate: filteredRates[index]),
                              childCount: filteredRates.length,
                            ),
                          ),
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
