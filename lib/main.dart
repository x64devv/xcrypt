import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'check_auth_state.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> fireApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: fireApp,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CheckAuthState();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Ooops: ${snapshot.error.toString()}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
