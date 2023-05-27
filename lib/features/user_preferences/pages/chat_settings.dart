import 'package:flutter/material.dart';
import 'package:matrix_chat_app/features/back_provider.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/background_selection.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/chat_settings.dart';
import 'package:matrix_chat_app/features/user_preferences/widgets/catalogue.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/font_selection.dart';
import 'package:provider/provider.dart';

class ChatSettings extends StatefulWidget {
  ChatSettings({Key? key}) : super(key: key);

  @override
  State<ChatSettings> createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("SETTINGS",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return ChangeNotifierProvider.value(
                        value: Provider.of<BackgroundProvider>(context),
                        child: const BackgroundSelection());
                  }));
                },
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Background Images',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'open sans',
                            color: Colors.white70),
                      ),
                    ))),
            Divider(
              height: 20,
              color: Colors.grey[600],
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return ChangeNotifierProvider.value(
                      value: Provider.of<BackgroundProvider>(context),
                      child: FontSelection());
                }));
              },
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Fonts',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'open sans',
                            color: Colors.white70),
                      ))),
            ),
            Divider(
              height: 20,
              color: Colors.grey[600],
            ),
          ]),
        ));
  }
}
