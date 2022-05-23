import 'package:flutter/material.dart';
import 'package:fixd/pages/page_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    // TO DO
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIXD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
