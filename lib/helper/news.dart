import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/articleModel.dart';
class NewsClass{
  List<ArticleModel> news = [];
  Future<void>getNews() async {
    String url = 'https://newsapi.org/v2/top-headlines?country=in&apiKey=d2b437f2cb38466ab7a7edbf64de06ca';
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel= ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["context"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass{
  List<ArticleModel> news = [];
  Future<void>getNews(String category) async {
    String url = 'https://newsapi.org/v2/top-headlines?country=in&category=$category&business&apiKey=d2b437f2cb38466ab7a7edbf64de06ca';
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null){
          ArticleModel articleModel= ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["context"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}