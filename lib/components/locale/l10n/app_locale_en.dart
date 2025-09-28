// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocaleEn extends AppLocale {
  AppLocaleEn([String locale = 'en']) : super(locale);

  @override
  String get search => 'Search';

  @override
  String get liked => 'liked!';

  @override
  String get disliked => 'disliked :(';

  @override
  String get titleAppBar => 'Manga App. Supported by MangaDex API';

  @override
  String get titleApp => 'Flutter Demo';

  @override
  String get description => 'description';

  @override
  String get manga => 'Manga';

  @override
  String get arbEnding => 'Чтобы не забыть про отсутствие запятой :)';
}
