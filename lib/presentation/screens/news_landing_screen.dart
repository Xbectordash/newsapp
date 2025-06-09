import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_bloc/news_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_bloc/news_event.dart';
import 'package:newsapp/bussiness/bloc/news_bloc/news_state.dart';
import 'package:newsapp/data/model/news_response_model.dart';
import 'package:newsapp/presentation/widget/card_widget.dart';
import 'package:newsapp/presentation/widget/search_bar_widget.dart';
import 'package:newsapp/presentation/widget/toggle_button_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsLandingScreen extends StatefulWidget {
  /// The main screen displaying news articles based on a selected topic.
  ///
  /// This screen supports:
  /// - Initial news fetching with pagination.
  /// - Pull-to-refresh functionality to reload news.
  /// - Infinite scroll loading more articles as user reaches the bottom.
  /// - Shows a loading skeleton while fetching data.
  /// - Displays errors if fetching news fails.
  /// - Includes a search bar and a theme toggle button in the app bar.
  ///
  /// It uses [NewsBloc] to manage state and events related to fetching and loading news data.
  const NewsLandingScreen({super.key});

  @override
  State<NewsLandingScreen> createState() => _NewsLandingScreenState();
}

/// State class for [NewsLandingScreen].
///
/// Manages the scroll controller and controls pagination,
/// refresh, and load-more events via [NewsBloc].
class _NewsLandingScreenState extends State<NewsLandingScreen> {
  /// Scroll controller to detect when user scrolls to bottom for loading more news.
  late ScrollController _scrollController;

  /// Current page number used for paginated API requests.
  int currentPage = 1;

  /// Number of articles per page to fetch.
  final int pageSize = 10;

  /// Default news topic to fetch articles for.
  final String topic = "India";

  /// Tracks number of API calls made (used internally).
  int numbersOfCalls = 0;

  /// Indicates if shimmering skeleton should be shown (loading effect).
  bool isShmerring = true;

  /// Indicates if the bottom loading spinner should show during load-more.
  bool bottomLoder = false;

  /// Indicates if a load-more operation is in progress.
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fetchInitialNews();
  }

  /// Triggers fetching the initial page of news articles from the bloc.
  void _fetchInitialNews() {
    context.read<NewsBloc>().add(
      FetchInitialNews(page: currentPage, pageSize: pageSize, topic: topic),
    );
  }

  /// Handles pull-to-refresh by resetting page to 1 and re-fetching initial news.
  Future<void> _onRefresh() async {
    currentPage = 1;
    numbersOfCalls = 1;
    debugPrint("on refresh called");
    _fetchInitialNews();
  }

  /// Listener for scroll events to detect when user reaches bottom.
  ///
  /// Automatically fetches the next page of news articles.
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
              // Show shimmering skeleton placeholders while loading
              return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => Skeletonizer(
                  enabled: true,
                  child: CardWidget(data: Article()),
                ),
              );
            } else if (state is NewsDataLoaded) {
              // Show loaded news articles and optionally a loading spinner at bottom for pagination
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
              // Show error message on failure
              final error = state.errormssg;
              return Center(child: Text(error));
            } else {
              // Default empty container for any other state
              return Container();
            }
          },
        ),
      ),
    );
  }
}
