import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const JolobbiApp());
}

class JolobbiApp extends StatelessWidget {
  const JolobbiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jolobbi Dev',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
