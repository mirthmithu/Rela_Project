import 'package:app/pages/call.dart';
import 'package:app/pages/nurse.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'package:app/pages/dept.dart';
// Import the second Dart file

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _userId = _generateRandomUserId();
  late String _currentDateTime = '';

  @override
  void initState() {
    super.initState();
    _getCurrentDateTime();
  }

  void _getCurrentDateTime() {
    setState(() {
      _currentDateTime = _formatDateTime(DateTime.now());
    });
    Future.delayed(Duration(seconds: 1), () => _getCurrentDateTime());
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${_addLeadingZero(dateTime.month)}-${_addLeadingZero(dateTime.day)} '
        '${_addLeadingZero(dateTime.hour)}:${_addLeadingZero(dateTime.minute)}:${_addLeadingZero(dateTime.second)}';
  }

  String _addLeadingZero(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  String _generateRandomUserId() {
    final math.Random _random = math.Random.secure();
    final values = List<int>.generate(16, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 215, 193, 255),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ' User ID: $_userId',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _currentDateTime,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DepartmentPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "DOCTOR",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NursePage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NURSE",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DepartmentPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ALLIED",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DepartmentPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "EMERGENCY",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Call()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SWITCH BOARD",
                        textAlign: TextAlign.center, // Center the text

                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          ),
        ),
      ),
    );
  }
}
