import 'package:flutter/material.dart';
import 'package:mvp_platform/widgets/test/http_test_connection.dart';

class HttpConnectionScreen extends StatelessWidget {
  static const routeName = '/http-connection-screen';

  HttpConnectionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TestHttpConnectionForm(),
      ),
    );
  }
}
