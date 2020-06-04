import 'package:flutter/material.dart';
import 'package:mvp_platform/widgets/home/tabs/notifications/gos_notifications.dart';
import 'package:mvp_platform/widgets/home/tabs/services.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  final List<Tab> tabs = [
    Tab(text: GosNotificationsTab.tabName),
    Tab(text: Services.tabName),
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
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TabBar(
            controller: tabController,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black54,
            tabs: tabs,
          ),
          Container(
            height: screenHeight * 0.25,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                GosNotificationsTab(),
                Services(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
