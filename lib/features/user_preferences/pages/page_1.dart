import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class Settings extends StatefulWidget {
  final ProfileInformation profile;
  const Settings({super.key, required this.profile});

  @override
  State<Settings> createState() => _SettingsState();
}

late ProfileInformation profile;

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Preferences",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.person_2_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                      Expanded(
                        flex: 100,
                        child: TextButton(
                          style: ButtonStyle(),
                          onPressed: () {},
                          child: Text('Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
            ],
          ),
        ));
  }
}
