import 'package:flutter/material.dart';

import '/presentation/resources/app_strings.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.search,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
