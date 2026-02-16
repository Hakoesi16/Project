import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projetsndcp/cubit/authcubit.dart';
// import 'package:projetsndcp/signup/signup.dart';
import 'package:projetsndcp/signup/splage.dart';
void main() {
  runApp(BlocProvider(
    create: (_) => AuthCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(
      ),
    );
  }
}

