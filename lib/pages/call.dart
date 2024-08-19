import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

class Call extends StatelessWidget {
  const Call({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final maskedNumber = _maskPhoneNumber("9944951049");
            final Uri url = Uri(
              scheme: 'tel',
              path: maskedNumber,
            );
            launch(url.toString()); // Launch the phone call using url_launcher
          },
          child: const Text('Call'), // Updated button text
        ),
      ),
    );
  }

  // Function to mask the phone number
  String _maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return phoneNumber.replaceRange(3, 7, 'XXXX');
    } else {
      // If the phone number is not in the expected format, return as is
      return phoneNumber;
    }
  }
}
