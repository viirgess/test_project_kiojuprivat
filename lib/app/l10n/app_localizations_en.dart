// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTitle => 'Home';

  @override
  String get ratesTitle => 'Exchange Rates';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get greeting =>
      'Welcome! Track exchange rates from the National Bank of Ukraine with ease. Stay informed about currency changes and manage your financial decisions efficiently.';

  @override
  String get openRates => 'Exchange Rates';

  @override
  String get openRatesSubtitle => 'View current currency rates';

  @override
  String get openSettings => 'Settings';

  @override
  String get openSettingsSubtitle => 'Customize your experience';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get updatedAt => 'Updated';

  @override
  String get search => 'Search by code or name';

  @override
  String get noResults => 'No results found';

  @override
  String get rateHistory => 'Rate History';

  @override
  String get noHistoryData => 'No history data available';

  @override
  String get days7 => '7 days';

  @override
  String get days30 => '30 days';

  @override
  String get days90 => '90 days';

  @override
  String get days180 => '180 days';

  @override
  String get days365 => '1 year';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get avg => 'Avg';

  @override
  String get change => 'Change';

  @override
  String get theme => 'Theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get language => 'Language';

  @override
  String get ukrainian => 'Українська';

  @override
  String get english => 'English';
}
