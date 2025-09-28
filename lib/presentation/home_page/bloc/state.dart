import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/domain/models/card.dart';
import 'package:flutter_test_app/domain/models/home.dart';

class HomeState extends Equatable {
  final HomeData? data;
  final bool isLoading;
  final bool isPaginationLoading;
  final int offset;
  const HomeState({
    this.data,
    this.isLoading = false,
    this.isPaginationLoading = false,
    this.offset = 0,
  });
  HomeState copyWith({
    HomeData? data,
    bool? isLoading,
    bool? isPaginationLoading,
    int? offset,
  }) => HomeState(
    data: data ?? this.data,
    isLoading: isLoading ?? this.isLoading,
    isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    offset: offset ?? this.offset,
  );
  @override
  List<Object?> get props => [data, isLoading, isPaginationLoading];
}
