import 'package:flutter/material.dart';
import 'package:pawsapp/views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pawsapp',
      theme: ThemeData(
        // primarySwatch: Colors.teal[900],
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
        primaryColor: Color.fromRGBO(230, 152, 129, 1),
        buttonColor: Colors.teal[900],
      ),
      home: MyHomePage(),
    );
  }
}
