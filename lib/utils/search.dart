import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final Function(String) callbackFind;

  CustomSearchDelegate({this.callbackFind});
  @override
  String get searchFieldLabel => 'Tìm kiếm';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // query = '';
          close(context, null);
          callbackFind(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pop(context);
      callbackFind(query);
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
