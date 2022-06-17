import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:josequel_task/api_key.dart';
import 'package:josequel_task/Model/Wallpaper.dart';

class ProjectProvider extends ChangeNotifier {
  ProjectProvider() {
    Box favWallpapersBox = Hive.box('favwallpapersbox');
    favWallpapers = favWallpapersBox.get('favwallpapers', defaultValue: []);
    searchedWallpapers = [];
  }
  static Dio? _dioInstance;
  late List<WallPaper> searchedWallpapers;
  late String savePath;
  static Dio? get instance {
    _dioInstance ??= Dio(BaseOptions(
        headers: {'Authorization': ApiKey},
        baseUrl: 'https://api.pexels.com/v1/'));
    return _dioInstance;
  }

  late List favWallpapers;

  Future<void> getWallpapers(
      int pageKey,
      void Function(List<WallPaper> newList, int pageKey) addNewWallpapers,
      void Function(List<WallPaper> list) indicateLastPage) async {
    Response response =
        await instance!.get('curated?page=$pageKey&per_page=20');
    List newItems = response.data['photos'];
    final bool isLastPage = newItems.length < 20;
    if (isLastPage) {
      indicateLastPage(newItems.map((e) => WallPaper.fromMap(e)).toList());
    } else {
      addNewWallpapers(
          newItems.map((e) => WallPaper.fromMap(e)).toList(), pageKey);
    }
  }

  Future<List<String>> searchWallpapers(String query) async {
    List<String> resultWallpapers = [];
    if (query.isNotEmpty) {
      Response response = await _dioInstance!
          .get('https://api.pexels.com/v1/search?query=$query&per_page=10');
      List data = response.data['photos'];
      resultWallpapers = data.map((map) => map['alt'].toString()).toList();
      searchedWallpapers = data.map((map) => WallPaper.fromMap(map)).toList();
    }

    return resultWallpapers;
  }

  void addToFavourites(WallPaper wallpaper) {
    favWallpapers.add(wallpaper.toMap());
    log(favWallpapers.toString());
    Box favWallpapersBox = Hive.box('favwallpapersbox');
    favWallpapersBox.put('favwallpapers', favWallpapers);
  }

  void removeFromFavourites(WallPaper wallpaper) {
    favWallpapers.removeWhere((map) {
      return map['id'] == wallpaper.id;
    });
    log(favWallpapers.toString());
    Box favWallpapersBox = Hive.box('favwallpapersbox');
    favWallpapersBox.put('favwallpapers', favWallpapers);
  }

  void downloadWallpaper(WallPaper wallPaper) {
    FlutterDownloader.enqueue(
        fileName: wallPaper.name.isNotEmpty ? "${wallPaper.name}.jpg" : null,
        url: wallPaper.urlLarge,
        savedDir: savePath,
        showNotification: true,
        saveInPublicStorage: true,
        openFileFromNotification: false);
  }
}
