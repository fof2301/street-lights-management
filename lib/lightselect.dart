import 'package:flutter/material.dart';
import 'package:iotproject/constants/colors.dart';
import 'package:iotproject/home.dart';
import 'package:iotproject/light1.dart';
import 'package:iotproject/light2.dart';
import "package:http/http.dart" as http;
import "package:html/dom.dart" as dom;

class lighter extends StatefulWidget {
  const lighter({Key? key}) : super(key: key);
  @override
  State<lighter> createState() => _lighterState();
}

class _lighterState extends State<lighter> {
  var midIntensity = "MID";
  var hiIntensity = "HIGH";
  var offIntensity = "OFF";
  var displayIntensity = "OFF";
  var displayIntensity2 = "OFF";
  var b00l = true;
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
      setState(() {
        displayIntensity = offIntensity;
      });

      b00l = false;
    }

    if (tits[0] == "Az") {
      setState(() {
        displayIntensity = midIntensity;
      });

      b00l = false;
    }
    if (tits[0] == "AZ") {
      setState(() {
        displayIntensity = hiIntensity;
      });

      b00l = false;
    }
    if (tits[1] == "cd") {
      setState(() {
        displayIntensity2 = offIntensity;
      });

      b00l = false;
    }

    if (tits[1] == "Cd") {
      setState(() {
        displayIntensity2 = midIntensity;
      });

      b00l = false;
    }
    if (tits[1] == "CD") {
      setState(() {
        displayIntensity2 = hiIntensity;
      });

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
        title: Text("SELECT A LIGHT"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: ListTile(
              title: Text(
                "LIGHT 1",
                style: TextStyle(fontSize: 25),
              ),
              subtitle: Text(
                displayIntensity,
                style: TextStyle(fontSize: 15),
              ),
              contentPadding: EdgeInsets.fromLTRB(50, 10, 100, 10),
              onTap: () {
                stater();
              },
              onLongPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => light1()));
              },
            ),
          ),
          Center(
            child: ListTile(
              title: Text(
                "LIGHT 2",
                style: TextStyle(fontSize: 25),
              ),
              subtitle: Text(
                displayIntensity2,
                style: TextStyle(fontSize: 15),
              ),
              contentPadding: EdgeInsets.fromLTRB(50, 10, 100, 10),
              onTap: () {
                stater();
              },
              onLongPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => light2()));
              },
            ),
          ),
          // Center(
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(fixedSize: const Size(20, 10)),
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => light3()));
          //       },
          //       child: Text("3")),
          // ),
          // Center(
          //   child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(fixedSize: const Size(20, 10)),
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => light4()));
          //       },
          //       child: Text("4")),
          // ),
          Center(
            child: ListTile(
              leading: Text(
                "MAP",
                style: TextStyle(fontSize: 20),
              ),
              contentPadding: EdgeInsets.fromLTRB(50, 10, 100, 10),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => home()));
              },
            ),
          )
        ],
      ),
    );
  }
}
