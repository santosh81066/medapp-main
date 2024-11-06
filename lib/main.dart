import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gomedserv/home/dashboard_screen.dart';
import 'package:gomedserv/login.dart';
import 'package:gomedserv/providers/auth.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          print("build main.dart");
          final authState = ref.watch(authProvider);

          // Check if the user has a valid refresh token and user status
          if (authState.data.refreshToken.isNotEmpty) {
            print('Refresh token exists: ${authState.data.refreshToken}');
            return DashboardScreen(); // User is authenticated, redirect to Home
          } else {
            print('No valid refresh token, trying auto-login');
          }

          // Attempt auto-login if the refresh token is not in the state
          return FutureBuilder<bool>(
            future: ref.read(authProvider.notifier).tryAutoLogin(),
            builder: (context, snapshot) {
              print(
                  'Token after auto-login attempt: ${authState.data?.accessToken}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); // Show a loading indicator while waiting
              } else if (snapshot.hasData &&
                  snapshot.data == true &&
                  authState.data.refreshToken.isEmpty) {
                // If auto-login is successful, redirect to Home
                return DashboardScreen();
              } else {
                // If auto-login fails, show the Login page
                return const LoginScreen();
              }
            },
          );
        },
      ),
    );
  }
}
