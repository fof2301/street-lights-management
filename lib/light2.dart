import "dart:convert";
import "dart:io";
import "dart:math";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:iotproject/constants/colors.dart";
import "package:iotproject/home.dart";
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;
import 'dart:async';

class light2 extends StatefulWidget {
  light2({Key? key}) : super(key: key);

  @override
  State<light2> createState() => _light2State();
}

class _light2State extends State<light2> {
  @override
  var c = "lib/assets/lightlow.png";
  var prev_state = "";
  var b00l = true;
  late Timer t1;
  var lreqtime = DateTime.now();
  var ntime = DateTime.now();
  var check = true;
  var mantext = "MANUAL";
  var autotext = "AUTO";
  var deftext = "AUTO";
  var manual_bool = true;

  update() {
    lreqtime = DateTime.now();
    if (manual_bool == true) {
      stater();
    }

    check = true;
    ;
  }

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
    try {
      final url = Uri.parse(ip + "/?l1hi");
      final response1 = await http.get(url);
      _lightsSwitchHi();
    } catch (e) {}
  }

  Future _lightsOf() async {
    try {
      final url = Uri.parse(ip + "/?l1off");
      final response1 = await http.get(url);
      _lightsSwitchOff();
    } catch (e) {}
  }

  Future _lightsMi() async {
    try {
      final url = Uri.parse("$ip/?l1mid");
      final response1 = await http.get(url);
      _lightsSwitchOn();
    } catch (e) {}
  }

  Future stater() async {
    if (check == true) {
      print("start");
      check = false;
      print(check);
      final url = Uri.parse(ip);
      try {
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
          prev_state = "low";
        }

        if (tits[1] == "mid") {
          _lightsMi();
          prev_state = "mid";
        }
        if (tits[1] == "hi") {
          _lightsHi();
          prev_state = "hi";
        }
      } catch (e) {}
    }
  }

  void manual() {
    if (deftext == mantext) {
      deftext = autotext;
      setState(() {
        manual_bool = true;
      });
    }
    if (deftext == autotext) {
      deftext = mantext;
      setState(() {
        manual_bool = false;
      });
    }
  }

  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      update();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        title: Text("LIGHT 2"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          width: 500,
          height: 500,
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
                manual();
              },
              child: Text(
                deftext,
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
        )
      ]),
    );
  }
}
