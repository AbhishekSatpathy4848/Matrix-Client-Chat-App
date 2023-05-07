import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class Settings extends StatefulWidget {
  final Client client;
  final ProfileInformation profile;
  const Settings({
    super.key,
    required this.client,
    required this.profile,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("PROFILE",
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
              // CircleAvatar(
              //     child: Image(
              //   image: (),
              // )),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_2_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      TextButton(
                        style: ButtonStyle(),
                        onPressed: () {},
                        child: Text('Display Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${widget.profile.displayname}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Divider(
                  height: 0,
                  color: Colors.white,
                  thickness: 0.5,
                ),
              ),
              Spacer(),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                onPressed: () {
                  widget.client.logout();
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
