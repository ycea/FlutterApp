// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_locale.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocaleRu extends AppLocale {
  AppLocaleRu([String locale = 'ru']) : super(locale);

  @override
  String get search => 'Поиск';

  @override
  String get liked => 'в избранное!';

  @override
  String get disliked => 'не в избранном :(';

  @override
  String get titleAppBar => 'Приложение Manga. Поддержка API MangaDex';

  @override
  String get titleApp => 'Демонстрация Flutter';

  @override
  String get description => 'описание';

  @override
  String get manga => 'Манга';

  @override
  String get arbEnding => 'Чтобы не забыть про отсутствие запятой :)';
}
