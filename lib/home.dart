import 'package:flutter/material.dart';
import 'package:iotproject/about_us.dart';
import 'package:iotproject/constants/colors.dart';
import 'package:iotproject/hardware.dart';
import 'package:iotproject/home.dart';
import 'package:iotproject/about_us.dart';
import 'package:iotproject/lightselect.dart';
import 'package:iotproject/readme.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lgrey,
      appBar: _buildAppBar(),
      drawer: _extraDrawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Theme(
              data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => lighter()));
                  },
                  child: Image.asset(
                    "assets/map.png",
                  )))
        ],
      ),
    );
  }

  Drawer _extraDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.only(top: 100),
      children: [
        ListTile(
          title: const Text(
            'SYSTEM',
            style: TextStyle(fontSize: 40, fontFamily: "Rubik"),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => hardware()));
          },
        ),
        ListTile(
            title: const Text(
              'READ-ME',
              style: TextStyle(fontSize: 40, fontFamily: "Rubik"),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => readme()));
            }),
        ListTile(
          title: const Text(
            'ABOUT US',
            style: TextStyle(fontSize: 40, fontFamily: "Rubik"),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => about()));
          },
        ),
      ],
    ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: grey,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (Center(
            child: Text("SMART LIGHTS"),
          ))
        ],
      ),
    );
  }
}
