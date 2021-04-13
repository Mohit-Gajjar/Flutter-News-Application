import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/articleModel.dart';
import 'package:newsapp/models/categoryModel.dart';
import 'package:newsapp/views/articleview.dart';
import 'package:newsapp/views/categorynews.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<CategoryModel> categories = new List<CategoryModel>();
  // ignore: deprecated_member_use
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    NewsClass newsClass = NewsClass();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Daily'),
              Text('Samachar', style: TextStyle(color: Colors.blue))
            ],
          ),
          elevation: 0,
        ),
        body: _loading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryItem: categories[index].categoryName,
                              );
                            }),
                      ),
                      Column(children: <Widget>[
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: articles.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  imageUrl: articles[index].urlToImage,
                                  title: articles[index].title,
                                  desc: articles[index].description,
                              url: articles[index].url,);
                            }),
                      ]),
                    ],
                  ),
                ),
              ));
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryItem;
  CategoryTile({@required this.imageUrl,@required this.categoryItem});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context)=>CategoryNews(
          category: categoryItem.toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(children: [
          ClipRRect(
            child: CachedNetworkImage(imageUrl: imageUrl,
                width: 120, height: 60, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(6),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(
              categoryItem,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc,url;
  BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc,this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl:url,
          )
        ));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(imageUrl),
              borderRadius: BorderRadius.circular(6),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(desc),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
