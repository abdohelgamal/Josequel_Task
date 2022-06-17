import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:josequel_task/Controller/ProviderController.dart';
import 'package:josequel_task/View/WallPaperPage.dart';
import 'package:josequel_task/main.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProjectProvider provider =
        Provider.of<ProjectProvider>(navKey.currentContext!);
    return EasySearchBar(
        onSuggestionTap: (data) {
          FocusScope.of(context).unfocus();
          navKey.currentState!.push(MaterialPageRoute(builder: (context) {
            return WallPaperPage(provider.searchedWallpapers[provider
                .searchedWallpapers
                .indexWhere((wallPaper) => wallPaper.name == data)]);
          }));
        },
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        asyncSuggestions: provider.searchWallpapers,
        title: const Text('Welcome To Wallpapers App'),
        onSearch: (query) {});
  }

  @override
  Size get preferredSize => Size.fromHeight(
      MediaQuery.of(navKey.currentContext!).viewPadding.top + 35);
}
