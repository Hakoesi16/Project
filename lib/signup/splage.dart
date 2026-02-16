import 'dart:async';
import 'package:flutter/material.dart';

import 'firstpage.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

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
  Widget build(BuildContext context) {
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
              // Colors.blue.shade600,
              // Colors.blue.shade900,
              // Colors.blue.shade900,
            ],
          ),
        ),
        child: Container(
          width:double.infinity ,
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child:Image.asset("images/Logo2.png"),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Let’s Fishing",
            //       style: TextStyle(
            //         fontFamily: 'Poppins',
            //         fontSize: 30,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Icon(
            //       Icons.set_meal, // icône poisson
            //       color: Colors.white,
            //       size: 32,
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
