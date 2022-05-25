import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserPage extends StatelessWidget {
  final String? auth;
  const UserPage({Key? key, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return auth == null
        ? const UserWidget()
        : Consumer<UserProvider>(
            builder: (context, provider, child) {
              return FutureBuilder(
                future: provider.fetchUserInfo(auth!),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const UserWidget();
                },
              );
            },
          );
  }
}

class UserWidget extends StatelessWidget {
  final TextStyle data =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  final TextStyle header = const TextStyle(color: Colors.grey, fontSize: 18);

  const UserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
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
                Text(
                    provider.userModel.status != "NULL"
                        ? provider.userModel.data!.name
                        : "null",
                    style: data),
                const SizedBox(height: 25.0),
                Text('Email Address', style: header),
                Text(
                    provider.userModel.status != "NULL"
                        ? provider.userModel.data!.email
                        : "null",
                    style: data),
                const SizedBox(height: 25.0),
                Text('Phone Number', style: header),
                Text(
                    provider.userModel.status != "NULL"
                        ? provider.userModel.data!.phoneNumber
                        : "null",
                    style: data),
                const SizedBox(height: 25.0),
                Text('Country', style: header),
                Text(
                    provider.userModel.status != "NULL"
                        ? provider.userModel.data!.country
                        : "null",
                    style: data),
                const SizedBox(height: 25.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
