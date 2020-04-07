import 'package:flutter/material.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List _news = [];
  @override
  void initState() {
    // TODO: implement initState
    _fetchNews();
    super.initState();
  }

  _fetchNews() async {
    String newsUrl =
        "http://newsapi.org/v2/everything?q=covid19&from=2020-03-07&sortBy=publishedAt&apiKey=5ef6a7bc43bb42389d8ff1222c699615";
    http.Response data = await http.get(newsUrl);
    dynamic news = jsonDecode(data.body);
    setState(() {
      _news = news;
    });

    print(_news.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("News"),
    );
  }
}
