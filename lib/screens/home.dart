import 'package:flutter/material.dart';
import "../utils/countries.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _nums = [
    "1",
    "2",
  ];
  List<dynamic> countries = totalCountries;
  String _searchTerm = "";

  void _filterCountries(String searchTerm) {
    dynamic tempCountry = [];
    for (int i = 0; i < totalCountries.length; i++) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Highlights",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.5,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 150.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _nums.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 50,
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
                    child: Center(
                      child: Text(_nums[index]),
                    ),
                  );
                }),
          ),
          Divider(),
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
          // Center(
          //   child: Text(_searchTerm),
          // ),

          // Countries List
          SizedBox(height: 10),
          Expanded(
            child: Container(
              height: 400,
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 100,
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
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey[300],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 1.0,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              "https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/${countries[index]["iso2"].toString().toLowerCase()}.png",
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Divider(),
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
