import 'package:flutter/cupertino.dart';
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CreatePage()),
                  );
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

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    // CatService 객체 가져오기
    CatService catService = Provider.of<CatService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "좋아요 리스트",
          style: TextStyle(color: Colors.white),
        ),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: EdgeInsets.all(8),
        children: List.generate(catService.favoriteCatImages.length, (index) {
          String catImage = catService.favoriteCatImages[index];
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
                    color: Colors.red,
                  ),
                )
              ],
            ),
            onTap: () {
              catService.toggleFavoriteImage(catImage);
            },
          );
        }),
      ),
    );
  }
}
