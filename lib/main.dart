import 'package:bookmeworld/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Required for DateFormat
// import 'package:bookmeworld/screen/homepage.dart';
// // Your home screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //  Required before async code in main()
  await initializeDateFormatting(); //  Initialize intl locale data
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          const Navigationpage(), // Assuming HomePage is a StatelessWidget with const
    );
  }
}
