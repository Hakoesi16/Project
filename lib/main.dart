import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projetsndcp/picheur/Weather&Safety.dart';
import 'package:projetsndcp/picheur/interfacepage.dart';
import 'package:projetsndcp/picheur/profil.dart';
import 'package:projetsndcp/signin/cubit/authcubit.dart';
import 'package:projetsndcp/signin/cubit/themecubit.dart';
import 'package:projetsndcp/signin/signup/splage.dart';
import 'package:projetsndcp/vitirinaire/interfacevit.dart';
import 'package:projetsndcp/vitirinaire/PendingBatchesPage.dart';



import 'consumer/setupconsumer.dart';
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Let's Fishing",
          themeMode: themeMode,
          // --- THÈME CLAIR ---
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F7F9),
            primaryColor: const Color(0xFF013D73),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            cardTheme: CardThemeData( // Correction: CardThemeData au lieu de CardTheme
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          // --- THÈME SOMBRE ---
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            primaryColor: const Color(0xFF01A896),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E1E1E),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            cardTheme: CardThemeData( // Correction: CardThemeData au lieu de CardTheme
              color: const Color(0xFF1E1E1E),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white70),
            ),
            dividerTheme: const DividerThemeData(color: Colors.white12),
          ),
          home: const SetupConspage(token: '',),
          // SplashPage(),
          // Interfacepage(token: '',),
        );
      },
    );
  }
}

// void main() {
//   runApp(BlocProvider(
//     create: (_) => AuthCubit(),
//     child: MyApp(),
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashPage(),
//       // ProfilePage(token: '',),
//
//     );
//   }
// }
//
