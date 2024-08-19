import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app/pages/nurseTable.dart';

class NursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Floor'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DynamicDateTime(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloorButton(floorNumber: 1),
            SizedBox(height: 20),
            FloorButton(floorNumber: 2),
            SizedBox(height: 20),
            FloorButton(floorNumber: 3),
            SizedBox(height: 20),
            FloorButton(floorNumber: 4),
          ],
        ),
      ),
    );
  }
}

class DynamicDateTime extends StatefulWidget {
  @override
  _DynamicDateTimeState createState() => _DynamicDateTimeState();
}

class _DynamicDateTimeState extends State<DynamicDateTime> {
  late Timer _timer;
  late String _currentDateTime;

  @override
  void initState() {
    super.initState();
    _currentDateTime = _getCurrentDateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentDateTime = _getCurrentDateTime();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getCurrentDateTime() {
    DateTime now = DateTime.now();
    return '${_getFormattedDate(now)} ${_getFormattedTime(now)}';
  }

  String _getFormattedDate(DateTime dateTime) {
    return '${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  String _getFormattedTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(_currentDateTime);
  }
}

class FloorButton extends StatefulWidget {
  final int floorNumber;

  FloorButton({required this.floorNumber});

  @override
  _FloorButtonState createState() => _FloorButtonState();
}

class _FloorButtonState extends State<FloorButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WingSelectionPage(floorNumber: widget.floorNumber)),
        );
      },
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue.shade200 : Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Text(
          'Floor ${widget.floorNumber}',
          style: TextStyle(
            fontSize: 20,
            color: _isHovered ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

class WingSelectionPage extends StatelessWidget {
  final int floorNumber;

  WingSelectionPage({required this.floorNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Wing'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                WingButton(wingName: 'A', floorNumber: floorNumber),
                SizedBox(height: 20),
                WingButton(wingName: 'B', floorNumber: floorNumber),
                SizedBox(height: 20),
                WingButton(wingName: 'C', floorNumber: floorNumber),
                SizedBox(height: 20),
                WingButton(wingName: 'D', floorNumber: floorNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WingButton extends StatelessWidget {
  final String wingName;
  final int floorNumber;

  WingButton({required this.wingName, required this.floorNumber});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => NurseTable()),
        );
      },
      child: Text(
        'Wing $wingName',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class WingDetailPage extends StatelessWidget {
  final String wingName;
  final int floorNumber;

  WingDetailPage({required this.wingName, required this.floorNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wing $wingName - Floor $floorNumber'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SearchBar(),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // replace with actual number of names
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Name $index'),
                  onTap: () {
                    // Handle name selection
                    // For now, let's just print it
                    print('Selected Name: Name $index');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search for a name...',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          // Implement search logic here
          // For now, let's just print the typed value
          print('Typed value: $value');
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
