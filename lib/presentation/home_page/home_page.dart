import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/data/repositories/manga_repository.dart';
import 'package:flutter_test_app/data/repositories/mock_repository.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/state.dart';

import '../../domain/models/card.dart';
import '../details_page/MangaDetails.dart';

part './card.dart';

class WidgetBody extends StatefulWidget {
  @override
  State<WidgetBody> createState() => _WidgetBodyState();
}

class _WidgetBodyState extends State<WidgetBody> {
  final TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    scrollController.addListener(_onNextPageListener);
    super.initState();
  }

  void _onNextPageListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      final bloc = context.read<HomeBloc>();
      if (!bloc.state.isPaginationLoading) {
        bloc.add(
          HomeLoadDataEvent(
            search: searchController.text,
            offset: bloc.state.offset + 1,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _navToDetails(BuildContext context, CardData cardData) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MangaDetail(cardData)),
    );
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(
      HomeLoadDataEvent(search: searchController.text),
    );
    return Future.value(null);
  }

  void showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Манга $title ${isLiked ? 'добавлена в избранное' : 'убрана из избранного'}!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CupertinoSearchTextField(
              controller: searchController,
              onSubmitted: (search) {
                context.read<HomeBloc>().add(HomeLoadDataEvent(search: search));
              },
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.error != null
                ? Text(
                    state.error ?? "",
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: Colors.red),
                  )
                : state.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        itemCount: state.data?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final data = state.data?.data?[index];
                          return data != null
                              ? _Card.fromData(
                                  data,
                                  onLike: (title, isLiked) =>
                                      showSnackBar(context, title, isLiked),
                                  onTap: () => _navToDetails(context, data),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.isPaginationLoading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
