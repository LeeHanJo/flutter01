import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CatService extends ChangeNotifier {
  List<String> catImages = [];
  List<String> favoriteCatImages = [];

  CatService() {
    getRandomCatImages();
  }

  void getRandomCatImages() async {
    String path =
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg";
    var result = await Dio().get(path);
    for (int i = 0; result.data.length > i; i++) {
      var map = result.data[i];
      catImages.add(map['url']);
    }
    notifyListeners();
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteCatImages.contains(catImage)) {
      favoriteCatImages.remove(catImage);
    } else {
      favoriteCatImages.add(catImage);
    }
    notifyListeners();
  }
}
