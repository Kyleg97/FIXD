import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../providers/recall_provider.dart';
import '../providers/vin_provider.dart';
import 'page_recall.dart';

class VinPage extends StatelessWidget {
  VinPage({Key? key}) : super(key: key);

  final vinController = TextEditingController();

  final TextStyle data =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  final TextStyle header = const TextStyle(color: Colors.grey, fontSize: 18);
  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    padding: const EdgeInsets.all(10),
    primary: Colors.green,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<VinProvider>(
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
                        return 'Please enter a VIN';
                      }
                    },
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
                    child: provider.isFetching == false
                        ? ElevatedButton(
                            style: btnStyle,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await provider.getMakeAndModel(
                                    vinController.text.toString());
                                String make =
                                    provider.vinModel.results[6].value ??
                                        "null";
                                String model =
                                    provider.vinModel.results[8].value ??
                                        "null";
                                String year =
                                    provider.vinModel.results[9].value ??
                                        "null";
                                await Provider.of<RecallProvider>(context,
                                        listen: false)
                                    .getRecallData(make, model, year);
                                if (provider.vinModel.results[1].value == "0") {
                                  Get.to(() => const RecallPage());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Invalid VIN')));
                                }
                              }
                            },
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
      ),
    );
  }
}
