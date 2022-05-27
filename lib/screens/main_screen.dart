// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/service/api.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List topTrendingNewsList = [];
  final apiService = Get.put(ApiService());

  @override
  void initState() {
    getTopTrendingN();
    super.initState();
  }

  Future<void> getTopTrendingN() async {
    topTrendingNewsList = await apiService.getTopTrendingNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: getTopTrendingN(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: topTrendingNewsList.length,
                itemBuilder: (context, index) {
                  if (topTrendingNewsList[index].urlToImage == "null") {
                    topTrendingNewsList[index].changeUrlImageLink(
                        "https://cdn-60c35131c1ac185aa47dd21e.closte.com//wp-content/uploads/2020/06/cannot-load-photo.png");
                  }
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 20),
                              child: Image(
                                image: NetworkImage(
                                    topTrendingNewsList[index].urlToImage),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Text(
                                topTrendingNewsList[index].title + "\n",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 20),
                              child: Text(
                                topTrendingNewsList[index].description,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                },
              );
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ListTile(
              onTap: (){
                Get.to(()=>SearchScreen());
              },
              title: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
