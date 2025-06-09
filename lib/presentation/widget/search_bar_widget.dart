import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_bloc/news_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_bloc/news_event.dart';
import 'package:newsapp/helperFunctions/debouncing_helperFunction.dart';
import 'package:newsapp/helperFunctions/extention_theme_color_helperFunction.dart';

class SearchBarWidget extends StatefulWidget {
  /// A search input widget with debounce functionality to fetch news articles based on user input.
///
/// This widget provides a styled [TextField] for users to type search queries.
/// It uses a debounce mechanism to delay sending the search event until
/// the user stops typing for 400 milliseconds, minimizing unnecessary API calls.
///
/// When the user types, the input is debounced and then triggers a [FetchInitialNews]
/// event on the [NewsBloc] with the current search topic.
///
/// Visual features:
/// - Filled background color matching the theme's custom search field background.
/// - Rounded corners with a radius of 14.
/// - A search icon as prefix.
/// - Styled input borders with no visible lines for a clean look.
///
/// Usage example:
/// ```dart
/// SearchBarWidget()
/// ```
///
/// Dependencies:
/// - Uses the [Debounce] helper class for debouncing input.
/// - Dispatches events to [NewsBloc] to trigger news fetching based on the search query.
/// - Uses theme extension for custom colors via `context.customColors`.
///
/// Note:
/// The search input is case-sensitive and triggers the search event only after the debounce duration.
/// The text controller and debounce objects are properly disposed of when the widget is removed.
///


  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final Debounce _debounce = Debounce(Duration(milliseconds: 400));

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  void _fetchbysearch(String value) {
    debugPrint(value);
    context.read<NewsBloc>().add(FetchInitialNews(topic: value));
    // _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        _debounce(() => _fetchbysearch(value));
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: context.customColors.searchFieldBg,
        hint: Text("Search news....."),
        helperStyle: Theme.of(context).textTheme.bodySmall,
        prefixIcon: Icon(Icons.search),
        prefixIconColor: Theme.of(context).iconTheme.color,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: context.customColors.searchFieldBg,
          ),

          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: context.customColors.searchFieldBg,
          ),

          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
