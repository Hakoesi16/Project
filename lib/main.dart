import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projetsndcp/signin/cubit/authcubit.dart';
import 'package:projetsndcp/signin/signup/splage.dart';
// import 'package:projetsndcp/signup/signup.dart';
void main() {
  runApp(BlocProvider(
    create: (_) => AuthCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(
      ),
    );
  }
}

