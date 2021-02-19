import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp();
  final callable = FirebaseFunctions.instance.httpsCallable('addMessage',
    options: HttpsCallableOptions(timeout: Duration(seconds: 5)),
  );
  await callable(
      {"Teste2":"Teste do Aplicativo!"}
      ).then((v) {
    print(v.data);
  }).catchError((e) {
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gloss Express',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Container(
          child: Center(child: Text('Gloss Express')),
        ),
      ),
    );
  }
}