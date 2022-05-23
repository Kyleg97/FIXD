import 'package:fixd/api/api_login.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'page_user.dart';

class LoginPage extends StatefulWidget {
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
    bool isLoading = false;
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
              child: isLoading == false
                  ? RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () async {
                        // TO DO
                        //print("Log in button pressed");
                        setState(() {
                          isLoading = true;
                          print("setting isLoading to true");
                        });
                        UserModel userModel = await postLogin(
                            emailController.text, passwordController.text);
                        setState(() {
                          isLoading = false;
                          print("setting isLoading to false");
                        });
                        print("ok pushing new screen...");
                        print(userModel);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => UserPage(
                              userModel: userModel,
                            ),
                          ),
                        );
                        // Navigator.of(context).pushNamed('future_page');
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
  }
}
