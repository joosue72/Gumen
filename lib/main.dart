import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  home: new MyApp(),
));
}


class MyApp  extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 15,
      backgroundColor: Colors.black,
      image: Image.asset('assets/21362-animation.gif'),
      loaderColor: Colors.white,
      photoSize: 15.0,
      navigateAfterSeconds: MainScreen(),
      
    );
  }
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Splash Screen Example'),
      ),
      body: Center(
        child: Text(
          'MainScreen',
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      ),
    ),
    );
  }
}
