import 'package:fixd/api/api_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  final TextStyle data =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  final TextStyle header = const TextStyle(color: Colors.grey, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserProvider(),
      child: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return provider.isFetching
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
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
                        Text(provider.userModel.data?.name ?? "Name",
                            style: data),
                        const SizedBox(height: 25.0),
                        Text('Email Address', style: header),
                        Text(provider.userModel.data?.email ?? "Email Address",
                            style: data),
                        const SizedBox(height: 25.0),
                        Text('Phone Number', style: header),
                        Text(
                            provider.userModel.data?.phoneNumber ??
                                "Phone Number",
                            style: data),
                        const SizedBox(height: 25.0),
                        Text('Country', style: header),
                        Text(provider.userModel.data?.country ?? "Country",
                            style: data),
                        const SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
