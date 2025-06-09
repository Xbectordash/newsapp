import 'package:equatable/equatable.dart';
import 'package:newsapp/data/model/news_response_model.dart';

abstract class NewsState extends Equatable {}

class NewsDataInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsDataLoading extends NewsState {
  @override

  List<Object?> get props => [];
}

class NewsDataLoaded extends NewsState {
  final List<Article> newsData;
  final bool isLoadingMore;
  final String currentTopic;
  final int currentPage;
  final int pageSize;

  NewsDataLoaded({
    required this.newsData,
    required this.currentTopic,
    required this.currentPage,
    required this.pageSize,
    this.isLoadingMore = false,
  });

  NewsDataLoaded copyWith({
    List<Article>? newsData,
    bool? isLoadingMore,
    String? currentTopic,
    int? currentPage,
    int? pageSize,
  }) {
    return NewsDataLoaded(
      newsData: newsData ?? this.newsData,
      currentTopic: currentTopic ?? this.currentTopic,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
  @override

  List<Object?> get props => [newsData,currentPage,currentTopic,pageSize,isLoadingMore];
}


// }

class NewsDataError extends NewsState {
  final String errormssg;
  NewsDataError({required this.errormssg});
  @override
  List<Object?> get props => [errormssg];
}
