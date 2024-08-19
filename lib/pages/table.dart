import 'package:flutter/material.dart';
import 'package:app/pages/call.dart';
import 'package:app/pages/view.dart';
import 'package:app/pages/message.dart';

class TablePage extends StatefulWidget {
  const TablePage({
    Key? key,
  }) : super(key: key);

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("On-call Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ViewPage()),
              );
            },
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                DataTable(
                  columnSpacing: 20,
                  dataRowHeight: 110,
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Option 1')),
                    DataColumn(label: Text('Option 2')),
                    DataColumn(
                        label: Text('Message')), // New column for buttons
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('c123')),
                      DataCell(Text('John Doe')),
                      DataCell(MyIconButton(Icons.call, onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Call()),
                        );
                      })),
                      DataCell(MyIconButton(Icons.call, onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Call()),
                        );
                      })),
                      DataCell(MyIconButton(Icons.mail, onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      })),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('d123')),
                      DataCell(Text('Jane Smith')),
                      DataCell(MyIconButton(Icons.call, onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Call()),
                        );
                      })),
                      DataCell(MyIconButton(Icons.call, onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Call()),
                        );
                      })),
                      DataCell(MyIconButton(Icons.mail, onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      })),
                    ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  MyIconButton(this.icon, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
