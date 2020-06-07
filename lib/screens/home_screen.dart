import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_platform/widgets/home/lowertape/lower_tape.dart';
import 'package:mvp_platform/widgets/home/tabs/tabs.dart';
import 'package:mvp_platform/widgets/home/uppertape/upper_tape.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/home-screen';

  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/gos-main-logo.png',
                fit: BoxFit.cover,
                height: 35.0,
              ),
            ],
          ),
          leading: IconButton(
              icon: Icon(Icons.menu), color: Colors.black, onPressed: () => {}),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: IconButton(
                  icon: Icon(CupertinoIcons.search),
                  color: Colors.black,
                  onPressed: () => {}),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: UpperTape(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Tabs(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: LowerTape(),
            ),
          ],
        ),
      ),
    );
  }
}
