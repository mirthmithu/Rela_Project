import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule Table',
          style: TextStyle(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color:
                Color.fromARGB(255, 3, 109, 84), // Violet shade for the heading
            child: Center(
              child: Builder(
                builder: (BuildContext context) {
                  // Get the current date
                  DateTime now = DateTime.now();
                  String formattedDate =
                      '${now.day}  ${_getMonthName(now.month)} ${now.year}';

                  return Text(
                    '$formattedDate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                // Alternate row colors
                Color color = index % 2 == 0
                    ? Colors.grey.shade200
                    : Colors.grey.shade300;

                String text = '';
                if (index == 0) {
                  text = 'First On Call';
                } else if (index == 2) {
                  text = 'Second On Call';
                } else if (index == 4) {
                  text = 'Consultant';
                }

                String personName = '';
                if (index == 0 || index == 2 || index == 4) {
                  personName = 'Person ${index + 1}';
                }

                String timeSlot = '';
                if (index == 1) {
                  timeSlot = '8 AM - 9 AM';
                } else if (index == 3) {
                  timeSlot = '10 AM - 11 AM';
                } else if (index == 5) {
                  timeSlot = '2 PM - 3 PM';
                }

                return Container(
                  color: color,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(text),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: index == 0 || index == 2 || index == 4
                                ? Text(personName)
                                : index == 1 || index == 3 || index == 5
                                    ? Text(timeSlot)
                                    : Text(''),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: index == 0 || index == 2 || index == 4
                                ? Text(personName)
                                : index == 1 || index == 3 || index == 5
                                    ? Text(timeSlot)
                                    : Text(''),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: index == 0 || index == 2 || index == 4
                                ? Text(personName)
                                : index == 1 || index == 3 || index == 5
                                    ? Text(timeSlot)
                                    : Text(''),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
