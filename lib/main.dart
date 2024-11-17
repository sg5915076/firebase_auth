import 'package:firebase_auth_flutter/firebase_service/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_service/bloc/auth_bloc.dart';
import 'firebase_service/repo/auth_repository.dart';
import 'firebase_service/screens/login_screen.dart';
import 'firebase_service/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize authRepository
  final authRepository = AuthRepository();

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(authRepository),
      child: MyApp(authRepository: authRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  // Constructor to receive the authRepository
  MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
          create: (context) => AuthBloc(authRepository),
          child: LoginScreen(),
        ),
        '/signup': (context) => BlocProvider(
          create: (context) => AuthBloc(authRepository),
          child: SignupScreen(),
        ),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}


