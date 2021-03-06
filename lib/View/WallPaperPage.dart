import 'package:flutter/material.dart';
import 'package:josequel_task/Controller/ProviderController.dart';
import 'package:josequel_task/Model/Wallpaper.dart';
import 'package:provider/provider.dart';

class WallPaperPage extends StatelessWidget {
  const WallPaperPage(this.wallPaper, {Key? key}) : super(key: key);
  final WallPaper wallPaper;
  @override
  Widget build(BuildContext context) {
    ProjectProvider provider = Provider.of<ProjectProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 70),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(wallPaper.urlLarge),
                    fit: BoxFit.cover)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatefulBuilder(builder: (context, setstate) {
                    bool isFavourite = provider.favWallpapers
                        .any((map) => map["id"] == wallPaper.id);
                    return IconButton(
                        icon: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 60,
                            color: isFavourite ? Colors.pink : Colors.blue),
                        onPressed: () {
                          setstate(() {
                            isFavourite
                                ? provider.removeFromFavourites(wallPaper)
                                : provider.addToFavourites(wallPaper);
                            isFavourite = !isFavourite;
                          });
                        });
                  }),
                  IconButton(
                      onPressed: () {
                       provider.downloadWallpaper(wallPaper);
                      },
                      color: Colors.red,
                      icon: const Icon(Icons.download, size: 60))
                ])));
  }
}
