import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:room_booking_app/book_a_room.dart';
import 'package:room_booking_app/login_page.dart';
import 'package:room_booking_app/view_bookings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List bookings = [];

  void _viewbookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await http.get(
      Uri.parse('$serverUrl/room-booking/view-bookings'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      bookings = json.decode(response.body);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ViewBookingsPage(bookings: bookings),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching bookings')),
      );
      throw Exception('Failed to load bookings');
    }
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            const Text(
              "Room Booking App",
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: _logout,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const BookaRoomPage(),
                  ),
                );
              },
              child: const Text("Book a Room"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _viewbookings,
              child: const Text("View Bookings"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
