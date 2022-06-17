import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:josequel_task/Controller/ProviderController.dart';
import 'package:josequel_task/Model/Wallpaper.dart';
import 'package:josequel_task/View/Components/SearchAppBar.dart';
import 'package:josequel_task/View/Favourites.dart';
import 'package:josequel_task/View/WallPaperPage.dart';
import 'package:josequel_task/main.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, WallPaper> _pagingController =
      PagingController(firstPageKey: 0);
  late ProjectProvider provider;

  void indicateLastPage(List<WallPaper> list) {
    _pagingController.appendLastPage(list);
  }

  void addNewWallpapers(List<WallPaper> newList, int pageKey) {
    final nextPageKey = pageKey + newList.length;
    _pagingController.appendPage(newList, nextPageKey);
  }

  @override
  void initState() {
    provider = Provider.of<ProjectProvider>(navKey.currentContext!);
    _pagingController.addPageRequestListener((pageKey) {
      provider.getWallpapers(pageKey, addNewWallpapers, indicateLastPage);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            onPressed: () {
              navKey.currentState!.push(
                  MaterialPageRoute(builder: (context) => const Favourites()));
            },
            label: const Text('Favourites')),
        appBar: const SearchAppBar(),
        body: PagedGridView<int, WallPaper>(
            padding: const EdgeInsets.all(15),
            builderDelegate: PagedChildBuilderDelegate(
                animateTransitions: true,
                itemBuilder: (context, wallPaper, index) {
                  return GestureDetector(
                      onTap: () {
                        navKey.currentState!
                            .push(MaterialPageRoute(builder: (context) {
                          return WallPaperPage(wallPaper);
                        }));
                      },
                      child: Stack(alignment: Alignment.bottomLeft, children: [
                        Image.network(wallPaper.urlLarge, fit: BoxFit.cover),
                        Text(wallPaper.name,
                            style: const TextStyle(color: Colors.white))
                      ]));
                }),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
            pagingController: _pagingController));
  }
}
