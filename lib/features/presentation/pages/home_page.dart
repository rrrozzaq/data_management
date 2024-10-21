import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.grey,  // Set the background color to grey
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button for "Data KK"
            SizedBox(
              width: 250,  // Adjust the width of the button
              height: 50,  // Adjust the height of the button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Set button color to black
                ),
                onPressed: () {
                  // Navigate to the "Data KK" page, which shows a list of KK
                  Navigator.pushNamed(context, '/data-kk');
                },
                child: const Text(
                  'Data KK',
                  style: TextStyle(color: Colors.white),  // White text color
                ),
              ),
            ),
            const SizedBox(height: 20),  // Add space between buttons
            // Button for "Input Data KTP"
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Set button color to black
                ),
                onPressed: () {
                  // Navigate directly to the Input KTP form
                  Navigator.pushNamed(context, '/input-ktp');
                },
                child: const Text(
                  'Input Data KTP',
                  style: TextStyle(color: Colors.white),  // White text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
