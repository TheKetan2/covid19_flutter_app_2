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
    _fetchNews();
    super.initState();
  }

  // _searchNewsTopic(String searchTerm) {
  //   if (searchTerm.length >= 3) _fetchNews();
  // }

  void _fetchNews() async {
    String newsUrl =
        "http://newsapi.org/v2/everything?q=${_searchTerm}&from=2020-03-07&sortBy=publishedAt&apiKey=5ef6a7bc43bb42389d8ff1222c699615";

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
    return Column(
      children: <Widget>[
        // TextField(
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(
        //         30.0,
        //       ),
        //       borderSide: BorderSide(
        //         width: 0.1,
        //       ),
        //     ),
        //     hintText: "Search for country",
        //     prefixIcon: Icon(Icons.search),
        //   ),
        //   // onSubmitted: (String value) {
        //   //   _searchNewsTopic(_searchTerm);
        //   // },
        //   onChanged: (String value) {
        //     setState(() {
        //       _searchTerm = value;
        //     });

        //     print("hi");
        //   },
        // ),
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: _news.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    height: 200.0,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[200],
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            imageUrl: _news[index]["urlToImage"],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          _news[index]["title"],
                          style: TextStyle(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
