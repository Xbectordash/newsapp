import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  /// Defines events for triggering news data operations in a BLoC or Cubit-based architecture.
  ///
  /// - [NewsEvent]: The abstract base class for all news-related events. Uses [Equatable]
  ///   to enable value-based equality for optimized state handling.
  ///
  /// Subclasses:
  ///
  /// - [FetchInitialNews]: Dispatched to fetch the first page of news articles for a given topic.
  ///   Accepts a [topic], and supports optional [page] and [pageSize] parameters for pagination.
  ///
  /// - [OnScrollingLoadmore]: Triggered when the user scrolls to the bottom, indicating that
  ///   more articles should be loaded (e.g., for infinite scrolling).

  const NewsEvent();
}

// Initial fetch event
class FetchInitialNews extends NewsEvent {
  ///
  /// - [FetchInitialNews]: Dispatched to fetch the first page of news articles for a given topic.
  ///   Accepts a [topic], and supports optional [page] and [pageSize] parameters for pagination.
  ///
  final String topic;
  final int page;
  final int pageSize;

  const FetchInitialNews({
    required this.topic,
    this.page = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [topic, page, pageSize];
}

// Scroll/pagination event
class OnScrollingLoadmore extends NewsEvent {
  ///
  /// - [OnScrollingLoadmore]: Triggered when the user scrolls to the bottom, indicating that
  ///   more articles should be loaded (e.g., for infinite scrolling).
  @override
  List<Object?> get props => [];
}
