import 'package:flutter/material.dart';
import "../utils/countries.dart";
import 'package:cached_network_image/cached_network_image.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic _totalCountries = [], filtered;

  List _nums = [
    "1",
    "2",
  ];
  List<dynamic> countries = totalCountries;
  String _searchTerm = "";

  _fetchCovidSata() async {
    String urlCountries = "https://corona.lmao.ninja/countries";
    String urlTotal = "https://corona.lmao.ninja/all";
    try {
      http.Response dataCountries = await http.get(urlCountries);
      http.Response dataTotal = await http.get(urlTotal);
      dynamic decodeCountries = jsonDecode(dataCountries.body);
      dynamic decodeTotal = jsonDecode(dataTotal.body);
      print(decodeTotal["cases"]);
      print(decodeCountries[0]["country"]);
      setState(() {
        _totalCountries = decodeCountries;
      });
    } catch (error) {
      print("something went wrong...");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchCovidSata();
    super.initState();
  }

  void _filterCountries(String searchTerm) {
    dynamic tempCountry = [];
    for (int i = 0; i < _totalCountries.length; i++) {
      if (totalCountries[i]["name"]
          .toLowerCase()
          .startsWith(searchTerm.toLowerCase())) {
        tempCountry.add(totalCountries[i]);
      }
    }
    searchTerm.length == 0
        ? setState(() {
            countries = totalCountries;
          })
        : setState(() {
            countries = tempCountry;
          });
    print(tempCountry[0]["name"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _totalCountries.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Loading data..."),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "World Highlights",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.5,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                Divider(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _fetchCovidSata();
                  },
                ),
                Text(
                  "All Countries",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                      borderSide: BorderSide(
                        width: 0.1,
                      ),
                    ),
                    hintText: "Search for country",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _searchTerm = value;
                    });
                    print("hi");
                    _filterCountries(_searchTerm);
                  },
                ),

                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    height: 400,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: countries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[200],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1.0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // padding: EdgeInsets.all(5.0),
                                // margin: EdgeInsets.all(5.0),
                                width: 70.0,
                                height: 70.0,
                                decoration: BoxDecoration(),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      imageUrl: _totalCountries[index]
                                          ["countryInfo"]["flag"],
                                      placeholder: (context, url) =>
                                          Image.asset(
                                              "assets/img/no_image.png"),
                                      fit: BoxFit.fill,
                                    )

                                    // Image.network(
                                    //   "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/${countries[index]["iso2"].toString().toLowerCase()}.png",
                                    //   height: 100.0,
                                    //   width: 100.0,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _totalCountries[index]["country"],
                                      style: TextStyle(
                                        letterSpacing: 1.1,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Text("2000"),
                                              Text("Total"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Text("2000"),
                                              Text("Cured"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Text("2000"),
                                              Text("Deaths"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // End of countries list
              ],
            ),
    );
  }
}
