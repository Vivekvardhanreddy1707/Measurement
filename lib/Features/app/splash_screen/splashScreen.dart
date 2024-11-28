import 'package:flutter/material.dart';

import '../../userauth/presentation/pages/login_page.dart';
class splashScreen extends StatefulWidget {
  final Widget?child;
  const splashScreen({super.key,this.child});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
 @override
  void initState() {
    Future.delayed(
      Duration(seconds:3),(){
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (Context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Text("Welcome to Cubimeter"),
      ),
    );
  }
}
