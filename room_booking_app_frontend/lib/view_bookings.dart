import 'package:flutter/material.dart';

class ViewBookingsPage extends StatelessWidget {
  final List bookings;

  const ViewBookingsPage({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "View Bookings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                'No bookings',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                var booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text('Room Number: ${booking['roomNumber']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Purpose: ${booking['purpose']}'),
                        Text('Club Name: ${booking['clubName']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
