import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quickride/intro/firstpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToFirstPage();
  }

  Future<void> _navigateToFirstPage() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Firstpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "assets/images/QUICK RIDE 2.png",
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
