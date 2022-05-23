import 'package:fixd/api/api_login.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserPage extends StatelessWidget {
  final UserModel userModel;
  UserPage({Key? key, required this.userModel}) : super(key: key);

  TextStyle data = const TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  TextStyle header = const TextStyle(color: Colors.grey, fontSize: 18);

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
                child: Image.asset('assets/profile.png'),
              ),
            ),
            const SizedBox(height: 50.0),
            Text('Name', style: header),
            Text(userModel.data.name, style: data),
            const SizedBox(height: 25.0),
            Text('Email Address', style: header),
            Text(userModel.data.email, style: data),
            const SizedBox(height: 25.0),
            Text('Phone Number', style: header),
            Text(userModel.data.phoneNumber, style: data),
            const SizedBox(height: 25.0),
            Text('Country', style: header),
            Text(userModel.data.country, style: data),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
