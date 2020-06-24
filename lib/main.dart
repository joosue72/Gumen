import 'package:flutter/material.dart';
import 'package:gumen/RegistroCliente.dart';
import 'dart:async';
import 'Login.dart';




void main() {
  runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
  routes: {
    'Empleado' : (BuildContext context) => RegistroCliente()
  },
));
}

int n1;

class MyApp  extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    super.initState();
    Future.delayed(
    Duration(seconds: 3),
    (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    },
  );
}

 


@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 300,
        ),
      ),
        
    );
  }
}