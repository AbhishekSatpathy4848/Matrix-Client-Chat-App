import 'package:flutter/material.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/background_selection.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/chat_settings.dart';
import 'package:matrix_chat_app/features/user_preferences/widgets/catalogue.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/font_selection.dart';

class ChatSettings extends StatefulWidget {
  const ChatSettings({Key? key}) : super(key: key);

  @override
  State<ChatSettings> createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[850],
          title: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                  'Settings',
                      style: TextStyle(
                  fontSize: 20,
                letterSpacing: 1.4,
                fontFamily: 'obitron',
              ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: 50, width: 450,
        color: Colors.grey[900],
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BackgroundSelection();
                }));
              },
            child: Align(
              alignment: Alignment.centerLeft,
                child: Text(
                    'Background Image',
                  style: TextStyle(fontSize: 25, fontFamily: 'EDU', color: Colors.white70),
                )
            ),
          ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FontSelection();
                }));
              },
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Background Image',
                    style: TextStyle(fontSize: 25, fontFamily: 'EDU', color: Colors.white70),
                  )
              ),
            ),
      ]
        ),
      ),
    );
  }
}
