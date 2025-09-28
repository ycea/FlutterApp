import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/components/extensions/LocalContextX.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_test_app/presentation/home_page/home_page.dart';
import 'package:flutter_test_app/presentation/like_bloc/like_bloc.dart';
import 'package:flutter_test_app/presentation/locale_bloc/locale_bloc.dart';
import 'package:flutter_test_app/presentation/locale_bloc/locale_state.dart';

import 'components/locale/l10n/app_locale.dart';
import 'data/repositories/manga_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      create: (context) => LocaleBloc(Locale(Platform.localeName)),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => context.locale.titleApp,
            locale: state.currentLocale,
            localizationsDelegates: AppLocale.localizationsDelegates,
            supportedLocales: AppLocale.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: RepositoryProvider<MangaRepository>(
              lazy: true,
              create: (_) => MangaRepository(),
              child: BlocProvider<LikeBloc>(
                lazy: false,
                create: (BuildContext context) => LikeBloc(),

                child: BlocProvider<HomeBloc>(
                  lazy: false,
                  create: (BuildContext context) =>
                      HomeBloc(context.read<MangaRepository>()),
                  child: MyHomePage(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(
          context.locale.titleAppBar,
          overflow: TextOverflow.visible,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: WidgetBody(),
    );
  }
}
