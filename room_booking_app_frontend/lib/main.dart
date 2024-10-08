import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:room_booking_app/home.dart';
import 'package:room_booking_app/login_page.dart';

void main() async{
  bool isLoggedIn = await _loginStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> _loginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token != null ? true : false ;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room-Booking-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color
            foregroundColor: Colors.white, //Text color
            shadowColor: Colors.blueAccent, // Shadow color
            elevation: 5, // Elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 20), // Padding
            textStyle: const TextStyle(
              fontSize: 18, // Font size
              fontWeight: FontWeight.normal, // Font weight
            ),
          ),
        ),
      ),
      home: isLoggedIn ? const HomeScreen() : const LoginPage(),
    );
  }
}
