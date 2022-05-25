import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/page_vin.dart';
import 'providers/recall_provider.dart';
import 'providers/user_provider.dart';
import 'pages/page_user.dart';
import 'package:provider/provider.dart';
import 'providers/vin_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? auth = prefs.getString('auth');

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => VinProvider()),
        ChangeNotifierProvider(create: (_) => RecallProvider()),
      ],
      child: MyApp(
        auth: auth,
      )));
}

class MyApp extends StatelessWidget {
  final String? auth;
  const MyApp({Key? key, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {'/home': (context) => HomePage()},
      title: 'FIXD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: auth == null ? const LoginPage() : HomePage(auth: this.auth!),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.all(10),
    primary: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return Form(
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
                        ? ElevatedButton(
                            style: btnStyle,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await provider.login(
                                    emailController.text.toString(),
                                    pwController.text.toString());
                                if (provider.userModel.status != "ERROR") {
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
    );
  }
}

class HomePage extends StatefulWidget {
  final String? auth;
  const HomePage({Key? key, this.auth}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [UserPage(auth: widget.auth), VinPage()];
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
