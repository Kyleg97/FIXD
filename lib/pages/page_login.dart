import 'package:fixd/api/api_login.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart';

class LoginPage extends StatefulWidget {
  // TO DO
  // static String tag = 'future_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              controller: passwordController,
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
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  // TO DO
                  //print("Log in button pressed");
                  postLogin(emailController.text, passwordController.text);
                  // Navigator.of(context).pushNamed('future_page');
                },
                padding: const EdgeInsets.all(10),
                color: Colors.green,
                child:
                    const Text('Log in', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
