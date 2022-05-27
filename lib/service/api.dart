// ignore_for_file: unused_import, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/get_search_news.dart';
import 'package:news_app/models/top_trending_news.dart';

class ApiService {
  Future<List<TopTrendingNews>> getTopTrendingNews() async {
    final uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=db26d214326844f5a392300e0f634c6e");
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    List<TopTrendingNews> temp = [];

    for (var i in data["articles"]) {
      //print(i);
      temp.add(TopTrendingNews.fromJson(i));
    }

    return temp;
  }

  Future<List<SearchedNews>> getSearchedNews(String str) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    final uri = Uri.parse(
        "https://newsapi.org/v2/everything?q=${str}&from=${formatted}&sortBy=popularity&apiKey=db26d214326844f5a392300e0f634c6e");
    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    List<SearchedNews> temp=[];

    for(var i in data["articles"]){
      temp.add(SearchedNews.fromJson(i));
    }
    return temp;
  }
}
