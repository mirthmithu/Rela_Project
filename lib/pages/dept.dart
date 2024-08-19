import 'dart:async';
import 'package:app/pages/table.dart';
import 'package:flutter/material.dart';

class DepartmentPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  String dropdownValue = 'Department';
  var items = [
    'Department',
    'OP1',
    'OP2',
    'Endoscopy',
    'Ward/ICU',
    'Prof Clinic'
  ];
  late Timer _timer;
  late String currentTime;
  TextEditingController searchController1 = TextEditingController();
  TextEditingController searchController2 = TextEditingController();
  bool departmentSelected = false; // Track whether department is selected

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = _getCurrentDateTime();
      });
    });
    currentTime = _getCurrentDateTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 215, 193, 255),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("EmpId:"),
            Text(
              currentTime,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.75),
                    width: 2,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey,
                  //     blurRadius: 5,
                  //     offset: Offset(2, 5),
                  //   ),
                  // ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "CONNECT TO DOCTOR",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                  height: 40), // Increased gap between heading and content
              _buildDropdownMenu(),
              const SizedBox(height: 30),
              const Text(
                "Search Rota by date:",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              _buildSearchByDate(),
              SizedBox(height: 30),
              Text(
                "Search doctor by name:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              _buildSearchByDoctorName(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        isDense: true,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              dropdownValue = newValue;
              departmentSelected = newValue !=
                  'Department'; // Set departmentSelected based on dropdown value
              if (newValue != 'Department') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TablePage()),
                );
              }
            });
          }
        },
      ),
    );
  }

  Widget _buildSearchByDate() {
    return InkWell(
      onTap: departmentSelected // Enable onTap only when department is selected
          ? () {
              _selectDate(context, searchController1);
            }
          : null,
      child: TextField(
        controller: searchController1,
        readOnly: true, // Make the text field read-only to prevent manual input
        decoration: InputDecoration(
          hintText: "Choose date",
          border: OutlineInputBorder(),
          suffixIcon: InkWell(
            onTap: () {
              _selectDate(context, searchController1);
            },
            child: Icon(Icons.calendar_today), // Calendar icon on the right
          ),
        ),
      ),
    );
  }

  Widget _buildSearchByDoctorName() {
    return TextField(
      controller: searchController2,
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage()),
          );
        }
      },
      decoration: InputDecoration(
        hintText: "Enter name",
        border: OutlineInputBorder(),
        suffixIcon:
            Icon(Icons.arrow_forward), // Arrow forward icon on the right
      ),
    );
  }

  String _getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDateTime =
        "${_formatDateTimeComponent(now.hour)}:${_formatDateTimeComponent(now.minute)} - ${_formatDateTimeComponent(now.day)}/${_formatDateTimeComponent(now.month)}/${now.year}";
    return formattedDateTime;
  }

  String _formatDateTimeComponent(int component) {
    return component < 10 ? '0$component' : '$component';
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('This is the next page.'),
      ),
    );
  }
}
