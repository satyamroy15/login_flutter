import 'package:flutter/material.dart';

import 'otp_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have logged in Successfully'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Future.delayed(const Duration(seconds: 0), () {
                    Navigator.pop(
                      context,
                    );
                  });
                },
                child: Text('Go Back'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
