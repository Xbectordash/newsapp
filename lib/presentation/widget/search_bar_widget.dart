import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_bloc.dart';
import 'package:newsapp/bussiness/bloc/news_api_management_bloc/news_event.dart';
import 'package:newsapp/helperfunctions/debouncing_helperfunction.dart';
import 'package:newsapp/helperfunctions/extention_theme_color_helperfunction.dart';

class SearchBarWidget extends StatefulWidget {
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
