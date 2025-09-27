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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    void _navToDetails(BuildContext context, CardData cardData) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MangaDetail(cardData)),
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CupertinoSearchTextField(
              controller: searchController,
              onSubmitted: (search) {
                setState(() {});
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, state) =>
                  FutureBuilder<List<CardData>?>(
                    future: state.data,
                    builder: (context, snapshot) => snapshot.hasData
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              final data = snapshot.data?[index];
                              return data != null
                                  ? _Card.fromData(
                                      data,
                                      onLike: (context, title, isLiked) =>
                                          showSnackBar(context, title, isLiked),
                                      onTap: () => _navToDetails(context, data),
                                    )
                                  : const SizedBox.shrink();
                            },
                          )
                        : const CircularProgressIndicator(),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
