import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sql.dart';
import 'like_event.dart';
import 'like_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

const String _likedPrefsKey = "liked";

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  Database? _db;
  LikeBloc() : super(const LikeState(likedIds: [])) {
    on<LoadLikesEvent>(_onLoadLikes);
    on<ChangeLikeEvent>(_onChangeLike);
    _initDb();
  }
  Future<void> _initDb() async {
    final path = join(await getDatabasesPath(), 'app.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE likes (
            id TEXT PRIMARY KEY
          )
        ''');
      },
    );
    add(const LoadLikesEvent());
  }

  Future<void> _onLoadLikes(
    LoadLikesEvent event,
    Emitter<LikeState> emit,
  ) async {
    final prefs = await _db?.query("likes");
    final data = prefs?.map((e) => e["id"] as String).toList() ?? [];
    emit(state.copyWith(likedIds: data));
  }

  Future<void> _onChangeLike(
    ChangeLikeEvent event,
    Emitter<LikeState> emit,
  ) async {
    final updatedList = List<String>.from(state.likedIds ?? []);
    if (updatedList.contains(event.id)) {
      updatedList.remove(event.id);
    } else {
      updatedList.add(event.id);
    }
    _db?.delete("likes");
    for (final id in updatedList) {
      _db?.insert("likes", {"id": id});
    }
    emit(state.copyWith(likedIds: updatedList));
  }
}
