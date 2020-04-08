import 'package:flutter/material.dart';
import "dart:convert";
import 'package:http/http.dart' as http;
import "package:cached_network_image/cached_network_image.dart";

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<dynamic> _news = [];
  String _searchTerm = "covid19";
  bool isLoading = true;
  @override
  void initState() {
    if (_news.length == 0) _fetchNews();
    super.initState();
  }

  // _searchNewsTopic(String searchTerm) {
  //   if (searchTerm.length >= 3) _fetchNews();
  // }

  void _fetchNews() async {
    String newsUrl =
        "https://newsapi.org/v2/everything?q=${_searchTerm}&sortBy=popularity&apiKey=5ef6a7bc43bb42389d8ff1222c699615";

    try {
      http.Response data = await http.get(newsUrl);
      dynamic news = jsonDecode(data.body);
      print(news);
      setState(() {
        _news = news["articles"];
      });
    } catch (error) {
      print("something went wrong..");
    }

    print(_news.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _news.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Loading news..."),
                ],
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _news.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  height: 355,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      //Image Container
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: _news[index]["urlToImage"] == null
                              ? Image.asset(
                                  "assets/img/no_image.png",
                                  fit: BoxFit.cover,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(9),
                                    topRight: Radius.circular(9),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: _news[index]["urlToImage"],
                                    placeholder: (context, url) => Image.asset(
                                      "assets/img/no_image.png",
                                      fit: BoxFit.cover,
                                      height: 400,
                                      width: double.infinity,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),

                      // News text container
                      Container(
                        padding: EdgeInsets.all(
                          5,
                        ),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _news[index]["title"].trim(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    _news[index]["content"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
