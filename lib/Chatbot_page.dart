import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  List<types.Message> _messages = [];
  final types.User _user = types.User(id: 'user');
  final types.User _bot = types.User(id: 'bot', firstName: 'BotNath');
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isRecorderInitialized = false;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
    setState(() {
      _isRecorderInitialized = true;
    });
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  void _addWelcomeMessage() {
    final textMessage = types.TextMessage(
      author: _bot,
      id: const Uuid().v4(),
      text: 'Hello, I’m BotNath! 👋 I’m your personal FAQ assistant. How can I help you?',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });
  }

  void _handleSendPressed() {
    final text = _textEditingController.text.trim();
    if (text.isNotEmpty) {
      final textMessage = types.TextMessage(
        author: _user,
        id: const Uuid().v4(),
        text: text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      setState(() {
        _messages.insert(0, textMessage);
        _textEditingController.clear();
      });

      // Simulate bot response
      Future.delayed(const Duration(seconds: 1), () {
        final botMessage = types.TextMessage(
          author: _bot,
          id: const Uuid().v4(),
          text: 'Ok, how about these?',
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );

        setState(() {
          _messages.insert(0, botMessage);
        });

        final botOptionsMessage = types.TextMessage(
          author: _bot,
          id: const Uuid().v4(),
          text: 'Appointment for Mayor\'s Office on\n25-07-2024\n\n3:00   4:00   5:00',
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );

        setState(() {
          _messages.insert(0, botOptionsMessage);
        });
      });
    }
  }

  void _toggleRecording() async {
    if (_isRecording) {
      await _recorder.stopRecorder();
    } else {
      if (await Permission.microphone.request().isGranted) {
        await _recorder.startRecorder(
          toFile: 'voice_note.aac',
        );
      } else {
        // Handle the case when the user denies microphone permission
      }
    }

    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'BotNath',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: (types.PartialText message) => _handleSendPressed(),
              user: _user,
              showUserNames: true,
              theme: DefaultChatTheme(
                inputBackgroundColor: Colors.white,
                inputTextColor: Colors.black,
                primaryColor: Colors.blue,
              ),
            ),
          ),
          _buildCustomInput(),
        ],
      ),
    );
  }

  Widget _buildCustomInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isRecording ? Icons.mic_off : Icons.mic,
              color: _isRecording ? Colors.red : Colors.black,
            ),
            onPressed: _isRecorderInitialized ? _toggleRecording : null,
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: _handleSendPressed,
          ),
        ],
      ),
    );
  }
}
