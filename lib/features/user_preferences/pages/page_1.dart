import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:matrix_chat_app/features/login_registration/pages/login_home.dart';

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
  void userLogOut() async {
    await widget.client.logout();
  }

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
                      const Icon(
                        Icons.person_2_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      TextButton(
                        style: const ButtonStyle(),
                        onPressed: () {},
                        child: const Text('Display Name',
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Divider(
                  height: 0,
                  color: Colors.white,
                  thickness: 0.5,
                ),
              ),
              const Spacer(),
              MaterialButton(
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                onPressed: () {
                  userLogOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Login()),
                    (route) => false,
                  );
                },
                child: const Text(
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
