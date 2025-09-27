import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test_app/data/repositories/manga_repository.dart';
import 'package:flutter_test_app/data/repositories/mock_repository.dart';

import '../../domain/models/card.dart';
import '../details_page/MangaDetails.dart';

part './card.dart';

class WidgetBody extends StatefulWidget {
  @override
  State<WidgetBody> createState() => _WidgetBodyState();
}

class _WidgetBodyState extends State<WidgetBody> {
  final MangaRepository repo = MangaRepository();
  final TextEditingController searchController = TextEditingController();

  late Future<List<CardData>?> data;

  @override
  void initState() {
    super.initState();
    data = repo.loadData();
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
                setState(() {
                  data = repo.loadData(query: search);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: FutureBuilder(
              future: data,
              builder: (context, asyncSnapshot) {
                return SingleChildScrollView(
                  child: asyncSnapshot.hasData
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: asyncSnapshot.data!
                              .map(
                                (data) => _Card.fromData(
                                  data,
                                  onLike: showSnackBar,
                                  onTap: () => _navToDetails(context, data),
                                ),
                              )
                              .toList(),
                        )
                      : const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
