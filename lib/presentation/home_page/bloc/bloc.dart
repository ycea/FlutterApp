import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_test_app/data/repositories/manga_repository.dart';
import 'package:flutter_test_app/domain/models/card.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MangaRepository repo;
  HomeBloc(this.repo) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(
    HomeLoadDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.offset == 0) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    final data = await repo.loadData(query: event.search, page: event.offset);
    if (event.offset != 0) {
      final oldData = state.data?.data ?? [];
      final newData = data?.data ?? [];

      final withoutFirst = newData.length > 1 ? newData.sublist(1) : [];

      data?.data
        ?..clear()
        ..addAll(oldData)
        ..addAll(withoutFirst as Iterable<CardData>);
    }

    emit(
      state.copyWith(
        data: data,
        isPaginationLoading: false,
        isLoading: false,
        offset: event.offset,
      ),
    );
  }
}
