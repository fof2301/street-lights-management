import "dart:convert";
import "dart:math";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:iotproject/constants/colors.dart";
import "package:iotproject/home.dart";
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;
import 'dart:async';

class light1 extends StatefulWidget {
  light1({Key? key}) : super(key: key);

  @override
  State<light1> createState() => _light1State();
}

class _light1State extends State<light1> {
  @override
  var c = "lib/assets/lightoff.png";
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
    final url = Uri.parse(ip + "/?l1hi");
    final response = await http.get(url);
    _lightsSwitchHi();
  }

  Future _lightsOf() async {
    final url = Uri.parse(ip + "/?l1off");
    final response = await http.get(url);
    _lightsSwitchOff();
  }

  Future _lightsMi() async {
    final url = Uri.parse(ip + "/?l1mid");
    final response = await http.get(url);
    _lightsSwitchOn();
  }

  Future stater() async {
    final url = Uri.parse(ip);
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    final titles = html
        .querySelectorAll('body > p:nth-child(1)')
        .map((element) => element.innerHtml.trim())
        .toList();
    var tits = titles[0].split(",");
    for (final title in titles) {
      print(tits[1]);
    }

    if (tits[1] == "low") {
      _lightsOf();
      b00l = false;
    }

    if (tits[1] == "mid") {
      _lightsMi();
      b00l = false;
    }
    if (tits[1] == "hi") {
      _lightsHi();
      b00l = false;
    }
  }

  Widget build(BuildContext context) {
    if (b00l == true) {
      stater();
    }
    Timer sttimer = Timer.periodic(Duration(seconds: 5), (timer) {
      stater();
    });
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
