import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp_platform/repository/rest_api.dart';
import 'package:http/http.dart' as http;

class TestHttpConnectionForm extends StatefulWidget {
  final String url;

  TestHttpConnectionForm({String url}) : url = url;

  @override
  State<StatefulWidget> createState() => TestHttpState();
}

class TestHttpState extends State<TestHttpConnectionForm> {
  String _url, _body;

  @override
  void initState() {
    _url = widget.url;
    super.initState();
  }

  _sendRequestPost() async {
    _body = await Service.get();
    setState(() {}); //reBuildWidget
  }

  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Container(
            child: Text('API url',
                style: TextStyle(fontSize: 20.0, color: Colors.blue)),
            padding: EdgeInsets.all(10.0)),
        RaisedButton(
            child: Text('Send request POST'), onPressed: _sendRequestPost),
        SizedBox(height: 20.0),
        Text('Response body',
            style: TextStyle(fontSize: 20.0, color: Colors.blue)),
        Text(_body == null ? '' : _body),
      ],
    )));
  } //buil
}
