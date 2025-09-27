import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_test_app/data/repositories/manga_repository.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MangaRepository repo;
  HomeBloc(this.repo) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  void _onLoadData(HomeEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repo.loadData()));
  }
}
