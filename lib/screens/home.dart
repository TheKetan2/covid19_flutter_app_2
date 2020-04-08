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
  dynamic _totalCountries = [],
      _filteredCountries = [],
      _worldData,
      forChartData;

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
        _filteredCountries = decodeCountries;
        _worldData = decodeTotal;
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
    print(_filteredCountries.length);
    dynamic tempCountry = [];
    for (int i = 0; i < _totalCountries.length; i++) {
      if (_totalCountries[i]["country"]
          .toLowerCase()
          .startsWith(searchTerm.toLowerCase())) {
        tempCountry.add(_totalCountries[i]);
      }
    }
    searchTerm.length == 0
        ? setState(() {
            _filteredCountries = _totalCountries;
          })
        : setState(() {
            _filteredCountries = [];

            _filteredCountries = tempCountry;
          });
    // print("ketan");
  }

  @override
  Widget build(BuildContext context) {
    var _controllerTE = TextEditingController();
    return Scaffold(
      body: _filteredCountries.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Loading data..."),
                ],
              ),
            )
          : Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "World Highlights",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.5,
                  ),
                ),

                //World Highlights
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[200],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildWorldCotainer(
                          data: "${_worldData["cases"]}" +
                              " [+${_worldData["todayCases"]}]",
                          title: "Cases",
                          color: Colors.orange),
                      _buildWorldCotainer(
                          data: "${_worldData["recovered"]}",
                          title: "Recovered",
                          color: Colors.green),
                      _buildWorldCotainer(
                          data: "${_worldData["cases"]}" +
                              " [+${_worldData["todayCases"]}]",
                          title: "Cases",
                          color: Colors.red),
                    ],
                  ),
                ),

                Text(
                  "All Countries",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.5,
                  ),
                ),

                SizedBox(height: 5),

                Expanded(
                  flex: 10,
                  child: Container(
                    // height: 300,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _filteredCountries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print("Hi");
                          },
                          child: Card(
                            elevation: 3.0,
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              width: double.infinity,
                              height: 65,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                // border: Border.all(
                                //   width: 1,
                                //   color: Colors.grey[200],
                                // ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey,
                                //     blurRadius: 1.0,
                                //   )
                                // ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: _filteredCountries[index]
                                              ["countryInfo"]["flag"],
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/img/no_image.png"),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          _filteredCountries[index]["country"],
                                          style: TextStyle(
                                            letterSpacing: 1.1,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            _buildCountryContainer(
                                                data: "${_filteredCountries[index]["cases"]}" +
                                                    "[+${_filteredCountries[index]["todayCases"]}]",
                                                title: "Total",
                                                color: Colors.orange,
                                                width: 110.0),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            _buildCountryContainer(
                                                data:
                                                    "${_filteredCountries[index]["recovered"]}",
                                                title: "Cured",
                                                color: Colors.green,
                                                width: 90.0),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            _buildCountryContainer(
                                                data: "${_filteredCountries[index]["deaths"]}" +
                                                    "[+${_filteredCountries[index]["todayDeaths"]}]",
                                                title: "Deaths",
                                                color: Colors.orange,
                                                width: 90.0),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // End of countries list
                Container(
                  padding: EdgeInsets.all(
                    5.0,
                  ),
                  child: TextField(
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
                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.clear, size: 20),
                      //   onPressed: () {
                      //     setState(() {
                      //       _searchTerm = "";
                      //     });
                      //   },
                      // ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _searchTerm = value;
                      });
                      // print("hi");
                      _filterCountries(_searchTerm);
                      print(_filteredCountries.length);
                    },
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Container(),
                ),
              ],
            ),
    );
  }

  Container _buildCountryContainer(
      {String data, String title, Color color, double width}) {
    return Container(
      width: width,
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
          Text(
            data,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11.0,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  Card _buildWorldCotainer({String data, String title, Color color}) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(
          5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data,
              style: TextStyle(
                color: color,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
