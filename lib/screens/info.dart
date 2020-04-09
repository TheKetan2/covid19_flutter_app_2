import "package:flutter/material.dart";

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.yellow[100],
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image.asset(
              "assets/img/symptoms.png",
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "HOW IT SPREADS",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.orange[400],
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2),
          ),
          Container(
            // height: 300.0,
            width: double.infinity,
            child: Image.asset(
              "assets/img/block-one.png",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "HOW IT SPREADS",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.green[500],
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            // height: 300.0,
            width: double.infinity,
            child: Image.asset(
              "assets/img/block-two.png",
            ),
          ),
        ],
      ),
    );
  }
}
