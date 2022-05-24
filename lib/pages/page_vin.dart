import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vin_provider.dart';

class VinPage extends StatelessWidget {
  VinPage({Key? key}) : super(key: key);

  final vinController = TextEditingController();

  final TextStyle data =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  final TextStyle header = const TextStyle(color: Colors.grey, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Consumer<VinProvider>(
      builder: (context, provider, child) {
        return provider.isFetching
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
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
                        controller: vinController,
                        decoration: InputDecoration(
                          hintText: 'Enter VIN',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Provider.of<VinProvider>(context, listen: false)
                                    .isFetching ==
                                false
                            ? RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () async {
                                  //await Provider.of<VinProvider>(context,
                                  //listen: false)
                                  // Get.to(() => CarInfoPage());
                                },
                                padding: const EdgeInsets.all(10),
                                color: Colors.green,
                                child: const Text('Search',
                                    style: TextStyle(color: Colors.white)),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
