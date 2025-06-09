
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_event.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_state.dart';
import 'package:newsapp/data/repo/news_api_services_repo.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsDataInitial()) {
    // Initial fetch
    on<FetchInitialNews>((event, emit) async {
      emit(NewsDataLoading());

      final topic = event.topic;
      final page = event.page;
      final pageSize = event.pageSize;

      try {
        final resData = await NewsApiService().fetchNews(
          topic: topic,
          page: page,
          pageSize: pageSize,
        );
        final articles = resData.articles ?? [];
        emit(
          NewsDataLoaded(
            newsData: articles,
            currentTopic: topic,
            currentPage: page,
            pageSize: pageSize,
          ),
        );
      } catch (e) {
        emit(NewsDataError(errormssg: e.toString()));
      }
    });

    on<OnScrollingLoadmore>((event, emit) async {
      if (state is NewsDataLoaded) {
        final currentState = state as NewsDataLoaded;
        final topic = currentState.currentTopic;
        final nextPage = currentState.currentPage + 1;
        final pageSize = currentState.pageSize;
        final currentList = currentState.newsData;

        try {
          emit(currentState.copyWith(isLoadingMore: true));

          final result = await NewsApiService().fetchNews(
            topic: topic,
            page: nextPage,
            pageSize: pageSize,
          );

          final newArticles = result.articles ?? [];
          final combined = List.of(currentList)..addAll(newArticles);

          emit(
            currentState.copyWith(
              newsData: combined,
              currentPage: nextPage,
              isLoadingMore: false,
            ),
          );
        } catch (e) {
          emit(NewsDataError(errormssg: e.toString()));
        }
      }
    });
  }
}
