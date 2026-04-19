import 'dart:async';
import 'package:flutter/material.dart';
import 'firstpage.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});// super.key permit identifier le widget dans l’arbre Flutter

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    // Attendre 3 secondes puis changer de page
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Firstpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {//methode qui construit l'interface graphic
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0172B2), // designer color
              Color(0xFF001645),
            ],
          ),
        ),
        child: Container(
          width:double.infinity ,
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child:Image.asset("images/Logo2.png"),
          ),
        ),
      ),
    );
  }
}
