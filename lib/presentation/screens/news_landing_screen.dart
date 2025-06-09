import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_event.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_state.dart';
import 'package:newsapp/data/model/news_response_model.dart';
import 'package:newsapp/presentation/widget/card_widget.dart';
import 'package:newsapp/presentation/widget/search_bar_widget.dart';
import 'package:newsapp/presentation/widget/toggle_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsLandingScreen extends StatefulWidget {
  const NewsLandingScreen({super.key});

  @override
  State<NewsLandingScreen> createState() => _NewsLandingScreenState();
}

class _NewsLandingScreenState extends State<NewsLandingScreen> {
  late ScrollController _scrollController;

  int currentPage = 1;
  final int pageSize = 10;
  final String topic = "India";
  int numbersOfCalls = 0;
  bool isShmerring = true;
  bool bottomLoder = false;
  bool isLoadingMore = false;

  @override
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fetchInitialNews();
  }

  void _fetchInitialNews() {
    context.read<NewsBloc>().add(
      FetchInitialNews(page: currentPage, pageSize: pageSize, topic: topic),
    );
  }

  Future<void> _onRefresh() async {
    currentPage = 1;
    numbersOfCalls = 1;
    debugPrint("on refresh called");

    _fetchInitialNews(); // reload first page
  }

  void _onScroll() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      debugPrint("onScroll called");
      currentPage++;
      context.read<NewsBloc>().add(OnScrollingLoadmore());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(126),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'News Mega',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    ThemeToggleButton(),
                  ],
                ),
                const SizedBox(height: 5),
                SearchBarWidget(),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.white,
        backgroundColor: Colors.blueAccent,
        displacement: 5,
        strokeWidth: 3.5,
        edgeOffset: 8,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsDataInitial || state is NewsDataLoading) {
              return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => Skeletonizer(
                  enabled: true,
                  child: CardWidget(data: Article()),
                ),
              );
            } else if (state is NewsDataLoaded) {
              final articles = state.newsData;
              final isLoadingMore = state.isLoadingMore;

              return ListView.builder(
                controller: _scrollController,
                itemCount: articles.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < articles.length) {
                    return CardWidget(data: articles[index]);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              );
            } else if (state is NewsDataError) {
              final error = state.errormssg;
              return Text(error);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
