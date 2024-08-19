import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  File? _imageFile;
  final picker = ImagePicker();
  String _currentUser = 'User 1'; // Initial user

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    List<ChatMessage> messages = await databaseHelper.getMessages();
    setState(() {
      _messages.addAll(messages);
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    String imagePath;
    if (_imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.png';
      final File newImage = await _imageFile!.copy('$path/$fileName');
      imagePath = newImage.path;
    } else {
      imagePath = '';
    }
    ChatMessage message = ChatMessage(
      text: text,
      imageFile: imagePath,
      sender: _currentUser,
    );
    setState(() {
      _messages.insert(0, message);
      _imageFile = null; // Reset image file after sending
      _toggleUser(); // Toggle to the next user
    });
    databaseHelper.insertMessage(message);
  }

  void _toggleUser() {
    if (_currentUser == 'User 1') {
      _currentUser = 'User 2';
    } else {
      _currentUser = 'User 1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Multimedia Chat'),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColorDark),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: getImage,
            ),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: "Send a message",
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String? imageFile;
  final String sender;

  ChatMessage({required this.text, this.imageFile, required this.sender});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'imageFile': imageFile,
      'sender': sender,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(sender.substring(
                  0, 1)), // Display first letter of sender's name
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(sender, style: Theme.of(context).textTheme.subtitle1),
                if (text.isNotEmpty) Text(text),
                if (imageFile != null && imageFile!.isNotEmpty)
                  Image.file(
                    File(imageFile!),
                    width: 200.0,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE chat_messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT,
        imagePath TEXT,
        sender TEXT
      )
    ''');
  }

  Future<void> insertMessage(ChatMessage message) async {
    final db = await database;
    await db.insert(
      'chat_messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatMessage>> getMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('chat_messages');
    return List.generate(maps.length, (i) {
      return ChatMessage(
        text: maps[i]['text'],
        imageFile: maps[i]['imagePath'],
        sender: maps[i]['sender'],
      );
    });
  }
}
