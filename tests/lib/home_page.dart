import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cat_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '랜덤고양이',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.cyan,
            actions: [
              IconButton(
                onPressed: () {
                  // 아이콘 버튼 눌렀을 때 동작
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            children: List.generate(catService.catImages.length, (index) {
              String catImage = catService.catImages[index];
              return GestureDetector(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        catImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 8,
                        right: 8,
                        child: Icon(
                          Icons.favorite,
                          color: catService.favoriteCatImages.contains(catImage)
                              ? Colors.red
                              : Colors.transparent,
                        ))
                  ],
                ),
                onTap: () {
                  catService.toggleFavoriteImage(catImage);
                },
              );
            }),
          ),
        );
      },
    );
  }
}
