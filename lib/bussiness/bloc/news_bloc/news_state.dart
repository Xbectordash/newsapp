import 'package:equatable/equatable.dart';
import 'package:newsapp/data/model/news_response_model.dart';

abstract class NewsState extends Equatable {
  /// Defines the various states used for managing news data in a BLoC or Cubit-based architecture.
///
/// - [NewsState]: The abstract base class for all news-related states. Implements [Equatable]
///   to ensure efficient state comparisons and updates.
/// 
/// Subclasses:
/// 
/// - [NewsDataInitial]: Represents the initial state before any data is loaded.
/// - [NewsDataLoading]: Indicates that news data is currently being fetched.
/// - [NewsDataLoaded]: Holds the successfully fetched list of [Article]s, along with
///   pagination details like `currentPage`, `pageSize`, `currentTopic`, and a flag
///   `isLoadingMore` for infinite scrolling scenarios. Includes a `copyWith` method for
///   immutable state transitions.
/// - [NewsDataError]: Represents an error state containing an error message string.
///
/// This state model supports responsive UI updates based on data fetching progress,
/// success, and failure.

}

class NewsDataInitial extends NewsState {
  /// - [NewsDataInitial]: Represents the initial state before any data is loaded.
  @override
  List<Object?> get props => [];
}

class NewsDataLoading extends NewsState {
  /// - [NewsDataLoading]: Indicates that news data is currently being fetched.
  @override

  List<Object?> get props => [];
}

class NewsDataLoaded extends NewsState {
/// - [NewsDataLoaded]: Holds the successfully fetched list of [Article]s, along with
///   pagination details like `currentPage`, `pageSize`, `currentTopic`, and a flag
///   `isLoadingMore` for infinite scrolling scenarios. Includes a `copyWith` method for
///   immutable state transitions.
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
  /// - [NewsDataError]: Represents an error state containing an error message string.
  final String errormssg;
  NewsDataError({required this.errormssg});
  @override
  List<Object?> get props => [errormssg];
}
