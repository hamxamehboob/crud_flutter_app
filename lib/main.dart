import 'package:crud_flutter_app/screens/home_screen.dart';
import 'package:crud_flutter_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Crud Application';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        title: _title,
      ),
    );
  }
}
