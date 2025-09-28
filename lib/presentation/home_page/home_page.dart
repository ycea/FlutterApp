import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/presentation/common/svg_objects.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_test_app/presentation/home_page/bloc/state.dart';

import 'package:flutter_test_app/domain/models/card.dart';
import 'package:flutter_test_app/presentation/like_bloc/like_state.dart';
import '../../components/extensions/LocalContextX.dart';
import '../../components/locale/l10n/app_locale.dart';
import '../../components/utils/Debounce.dart';
import '../details_page/MangaDetails.dart';
import '../like_bloc/like_bloc.dart';
import '../like_bloc/like_event.dart';
import '../locale_bloc/locale_bloc.dart';
import '../locale_bloc/locale_events.dart';
import '../locale_bloc/locale_state.dart';

part './card.dart';

class WidgetBody extends StatefulWidget {
  const WidgetBody({super.key});

  @override
  State<WidgetBody> createState() => _WidgetBodyState();
}

class _WidgetBodyState extends State<WidgetBody> {
  final TextEditingController searchController = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    SvgObjects.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    context.read<LikeBloc>().add(const LoadLikesEvent());
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
            !isLiked
                ? '${context.locale.manga} $title ${context.locale.liked}'
                : '${context.locale.manga} $title ${AppLocale.of(context)?.disliked}',
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    placeholder: context.locale.search,
                    onChanged: (search) {
                      Debounce.run(
                        () => context.read<HomeBloc>().add(
                          HomeLoadDataEvent(search: search),
                        ),
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    context.read<LocaleBloc>().add(const ChangeLocaleEvent()),
                child: SizedBox.square(
                  dimension: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: BlocBuilder<LocaleBloc, LocaleState>(
                      builder: (context, state) {
                        return state.currentLocale.languageCode == "ru"
                            ? const SvgRu()
                            : const SvgUK();
                      },
                    ),
                  ),
                ),
              ),
            ],
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
                : BlocBuilder<LikeBloc, LikeState>(
                    builder: (BuildContext context, LikeState likeState) {
                      return Expanded(
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
                                      onLike: _onLike,
                                      isLiked:
                                          likeState.likedIds?.contains(
                                            data.id,
                                          ) ==
                                          true,
                                      onTap: () => _navToDetails(context, data),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      );
                    },
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

  void _onLike(String? id, String title, bool isLiked) {
    if (id != null) {
      context.read<LikeBloc>().add(ChangeLikeEvent(id));
      showSnackBar(context, title, isLiked);
    }
  }
}
