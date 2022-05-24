import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'api.dart';
import 'models/user_model.dart';
import 'pages/page_vin.dart';
import 'providers/recall_provider.dart';
import 'providers/user_provider.dart';
import 'pages/page_user.dart';
import 'package:provider/provider.dart';

import 'providers/vin_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => VinProvider()),
    ChangeNotifierProvider(create: (_) => RecallProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _storage = const FlutterSecureStorage();

  final emailController = TextEditingController();
  final pwController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {'/home': (context) => HomePage()},
      title: 'FIXD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Form(
        key: _formKey,
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return Scaffold(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                      },
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
                      child: provider.isFetching == false
                          ? RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await provider.login(
                                      emailController.text.toString(),
                                      pwController.text.toString());
                                  if (provider.userModel.status != "ERROR") {
                                    /*await _storage.write(
                                        key: "EMAIL",
                                        value: emailController.text.toString());
                                    await _storage.write(
                                        key: "PASSWORD",
                                        value: pwController.text.toString());*/
                                    Get.to(() => HomePage());
                                  } else {
                                    emailController.clear();
                                    pwController.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Incorrect email/password')));
                                  }
                                }
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
            );
          },
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
  final List<Widget> _pages = [const UserPage(), VinPage()];

  @override
  void initState() {
    super.initState();
    // API.getUserInfo();
  }

  List<BottomNavigationBarItem> bottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle), label: 'Profile'),
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
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex,
      ),
    );
  }
}
