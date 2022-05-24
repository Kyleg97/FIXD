import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recall_provider.dart';

class RecallPage extends StatelessWidget {
  const RecallPage({Key? key}) : super(key: key);

  final TextStyle data = const TextStyle(fontSize: 18);
  final TextStyle header = const TextStyle(color: Colors.grey, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecallProvider>(
      builder: (context, provider, child) {
        var list = provider.recallModel.results;
        return provider.isFetching == true
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
                      Text('Manufacturer', style: header),
                      Text(list.isEmpty ? "null" : list[0].manufacturer,
                          style: data),
                      const SizedBox(height: 25.0),
                      Text('Summary', style: header),
                      Text(list.isEmpty ? "null" : list[0].summary,
                          style: data),
                      const SizedBox(height: 25.0),
                      Text('Consequence', style: header),
                      Text(list.isEmpty ? "null" : list[0].consequence,
                          style: data),
                      const SizedBox(height: 25.0),
                      Text('Remedy', style: header),
                      Text(list.isEmpty ? "null" : list[0].remedy, style: data),
                      const SizedBox(height: 25.0),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
