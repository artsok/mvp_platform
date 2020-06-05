import 'package:flutter/material.dart';
import 'package:mvp_platform/screens/home_screen.dart';
import 'package:mvp_platform/widgets/auth/number_or_email_tab.dart';
import 'package:mvp_platform/widgets/auth/snils_tab.dart';
import 'package:mvp_platform/widgets/common/buttons/gos_flat_button.dart';
import 'package:mvp_platform/utils/extensions/string_extensions.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  final List<Tab> tabs = [
    Tab(text: NumberOrEmailTab.tabName),
    Tab(text: SnilsTab.tabName),
  ];

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: ContinuousRectangleBorder(),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Wrap(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Вход',
                        style: TextStyle(
                          fontSize: 32.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      const Text(
                        'для портала Госуслуг',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        controller: tabController,
                        indicatorColor: Theme.of(context).primaryColor,
                        labelColor: Colors.black,
                        unselectedLabelColor: Theme.of(context).primaryColor,
                        tabs: tabs,
                      ),
                      Container(
                        height: 150,
                        child: TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            NumberOrEmailTab(),
                            SnilsTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GosFlatButton(
              text: 'Войти',
              textColor: Colors.white,
              backgroundColor: '#2763AA'.colorFromHex(),
              width: double.infinity,
              height: 48.0,
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                HomeScreen.routeName,
              ),
            ),
            Container(height: 8.0),
            GosFlatButton(
              text: 'Я не знаю пароль',
              height: 48.0,
              textColor: '#2763AA'.colorFromHex(),
              width: double.infinity,
              onPressed: () {},
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
