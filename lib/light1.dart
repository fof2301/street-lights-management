import "dart:convert";
import "dart:math";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:iotproject/constants/colors.dart";
import "package:iotproject/home.dart";
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;

class light1 extends StatefulWidget {
  light1({Key? key}) : super(key: key);

  @override
  State<light1> createState() => _light1State();
}

class _light1State extends State<light1> {
  @override
  var a = "assets/lightoff.png";
  var b = "assets/lighton.png";
  var d = "assets/lighthi.png";
  var c = "assets/lightoff.png";
  var b00l = true;

  void _lightsSwitchOn() {
    setState(() {
      c = b;
    });
  }

  void _lightsSwitchHi() {
    setState(() {
      c = d;
    });
  }

  void _lightsSwitchOff() {
    setState(() {
      c = a;
    });
  }

  void initState() {
    super.initState();
  }

  Future _lightsHi() async {
    final url = Uri.parse("http://192.168.167.21/?led=AZ");
    final response = await http.get(url);
    _lightsSwitchHi();
  }

  Future _lightsOf() async {
    final url = Uri.parse("http://192.168.167.21/?led=az");
    final response = await http.get(url);
    _lightsSwitchOff();
  }

  Future _lightsMi() async {
    final url = Uri.parse("http://192.168.167.21/?led=Az");
    final response = await http.get(url);
    _lightsSwitchOn();
  }

  Future stater() async {
    final url = Uri.parse("http://192.168.167.21");
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    final titles = html
        .querySelectorAll('body > p:nth-child(3)')
        .map((element) => element.innerHtml.trim())
        .toList();
    for (final title in titles) {
      print(titles);
    }
    var tits = titles[0].split(",");

    if (tits[0] == "az") {
      _lightsSwitchOff();
      b00l = false;
    }

    if (tits[0] == "Az") {
      _lightsSwitchOn();
      b00l = false;
    }
    if (tits[0] == "AZ") {
      _lightsSwitchHi();
      b00l = false;
    }
  }

  Widget build(BuildContext context) {
    if (b00l == true) {
      stater();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        title: Text("LIGHT 1"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
          child: Image.asset(c),
        ),
        Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                onPressed: () {
                  _lightsOf();
                },
                child: Text(
                  "OFF",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )),
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                onPressed: () {
                  _lightsMi();
                  ;
                },
                child: Text(
                  "MID",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )),
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                onPressed: () {
                  _lightsHi();
                },
                child: Text(
                  "HIGH",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )),
            ])),
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, elevation: 0),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => home()));
              },
              child: Text(
                "MAP",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
        )
      ]),
    );
  }
}
