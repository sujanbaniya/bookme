import 'package:bookmeworld/screen/homepage.dart';
import 'package:bookmeworld/screen/theater.dart';
import 'package:flutter/material.dart';

class Navigationpage extends StatelessWidget {
  const Navigationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NaviPage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TheaterPage()),
                );
              },

              child: const Text('Goto Theater page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoungeandPub()),
                );
              },

              child: const Text('Goto LoungeandPub page'),
            ),
          ],
        ),
      ),
    );
  }
}
