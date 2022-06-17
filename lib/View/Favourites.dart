import 'package:flutter/material.dart';
import 'package:josequel_task/Controller/ProviderController.dart';
import 'package:josequel_task/Model/Wallpaper.dart';
import 'package:josequel_task/View/WallPaperPage.dart';
import 'package:josequel_task/main.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProjectProvider provider = Provider.of<ProjectProvider>(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: const Text('Favourite Wallpapers'),
            centerTitle: true),
        body: provider.favWallpapers.isEmpty
            ? const Center(child: Text('No Favourite Wallpaper Has Been Added'))
            : GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(15),
                children: provider.favWallpapers
                    .map((wallPaperMap) => WallPaper.fromMap(wallPaperMap))
                    .toList()
                    .map((wallPaper) => GestureDetector(
                        onTap: () {
                          navKey.currentState!
                              .push(MaterialPageRoute(builder: (context) {
                            return WallPaperPage(wallPaper);
                          }));
                        },
                        child:
                            Stack(alignment: Alignment.bottomLeft, children: [
                          Image.network(wallPaper.urlLarge, fit: BoxFit.cover),
                          Text(wallPaper.name,
                              style: const TextStyle(color: Colors.white))
                        ])))
                    .toList()));
  }
}
