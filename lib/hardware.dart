import 'package:flutter/material.dart';
import 'package:iotproject/constants/colors.dart';
import 'package:iotproject/home.dart';

class hardware extends StatelessWidget {
  const hardware({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lgrey,
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: grey,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (Center(
            child: Text("HARDWARE CHECK"),
          ))
        ],
      ),
    );
  }
}
