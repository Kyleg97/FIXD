import 'package:flutter/material.dart';
import 'pages/page_login.dart';
import 'models/user_model.dart';
import 'pages/page_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIXD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      // routes: routes,
    );
  }
}

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UserModel userModel = await ;
  bool _loggedIn = false;
  int _currentIndex = 0;
  final List<Widget> _pages = [
    // UserPage(userModel: userModel),
    // VinPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  /*void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }*/

  List<BottomNavigationBarItem> bottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(Icons.verified_user_rounded), label: 'Profile'),
      const BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: 'VIN'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return _loggedIn == false
        ? LoginPage()
        : Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) => setState(() => _currentIndex = index),
              items: bottomNavBarItems(),
            ),
          );
  }
}
