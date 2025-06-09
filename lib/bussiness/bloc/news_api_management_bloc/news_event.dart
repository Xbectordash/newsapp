import 'package:equatable/equatable.dart';


abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

// Initial fetch event
class FetchInitialNews extends NewsEvent {
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
@override
  List<Object?> get props => [];
}
