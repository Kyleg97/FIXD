import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api.dart';
import 'models/user_model.dart';
import 'providers/user_provider.dart';
import 'pages/page_user.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {'/home': (context) => HomePage()},
      title: 'FIXD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("FIXD Login"),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            children: [
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 50.0,
                  child: Image.asset('assets/FIXD.jpg'),
                ),
              ),
              const SizedBox(height: 50.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                // initialValue: '',
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                autofocus: false,
                // initialValue: '',
                obscureText: true,
                controller: pwController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Provider.of<UserProvider>(context, listen: false)
                            .isFetching ==
                        false
                    ? RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () async {
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .login(emailController.text.toString(),
                                  pwController.text.toString());
                          Get.to(() => HomePage());
                        },
                        padding: const EdgeInsets.all(10),
                        color: Colors.green,
                        child: const Text('Log in',
                            style: TextStyle(color: Colors.white)),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const UserPage(),
    // VinPage()
  ];

  @override
  void initState() {
    super.initState();
    // API.getUserInfo();
  }

  List<BottomNavigationBarItem> bottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(Icons.verified_user_rounded), label: 'Profile'),
      const BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: 'VIN'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => _currentIndex = index),
        items: bottomNavBarItems(),
      ),
    );
  }
}
