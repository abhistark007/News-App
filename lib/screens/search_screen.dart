// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/get_search_news.dart';

import '../service/api.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SearchedNews> news = [];
  final apiService = Get.find<ApiService>();

  Future<void> getResults() async {
    news = await apiService.getSearchedNews(searchController.text);
    
  }

  TextEditingController searchController = TextEditingController();
  bool isLoading=true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for news"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                controller: searchController,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                     
                     if(searchController.text.isNotEmpty){
                      isLoading=false;
                      getResults(); 
                     }else{
                       isLoading=true;
                     }
                     
                  });
                 
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text("Search"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: isLoading?null:getResults(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: Text("Search to get news here!"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: news.length,
                        itemBuilder: (context, index) {
                          if (news[index].urlToImage == "null") {
                            news[index].changeUrlImageLink(
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
                                        image:
                                            NetworkImage(news[index].urlToImage),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Text(
                                        news[index].title + "\n",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 20),
                                      child: Text(
                                        news[index].description,
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
            ],
          ),
        ),
      ),
    );
  }
}
