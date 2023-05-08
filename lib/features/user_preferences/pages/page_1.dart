import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  late Uint8List bytes;
  final ImagePicker picker = ImagePicker();
  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    bytes = await image!.readAsBytes();
    widget.client.setAvatar(MatrixFile(bytes: bytes, name: 'Avatar'));
  }

  final TextEditingController _displayName = TextEditingController();

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.black,
            title: const Text('Change Display Name',
                style: TextStyle(
                  color: Colors.white,
                )),
            content: TextFormField(
              controller: _displayName,
              style: const TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                labelText: "Display Name",
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    widget.client.setDisplayName(
                        widget.client.userID!, '${_displayName.text}');
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: const Text('Done',
                      style: TextStyle(
                        color: Colors.white,
                      )))
            ]);
      },
    );
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
              Center(
                child: CircleAvatar(
                    radius: 50,
                    child: Image(
                      image: NetworkImage(
                          (widget.profile.avatarUrl!
                              .getThumbnail(widget.client,
                                  width: 150, height: 150)
                              .toString()),
                          scale: 1.0),
                    )),
              ),
              //replace this material button with a circular image wrapped with inkwell
              MaterialButton(
                  onPressed: () async {
                    pickImage();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (_) => Settings(
                              client: widget.client, profile: widget.profile)),
                      (route) => false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.blue,
                  child: const Text('Change Avatar',
                      style: TextStyle(color: Colors.white))),
              //userAvatar

              //
              // Image(
              //   image: MemoryImage(bytes!),
              // ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.person_2_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text('Display Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                child: Row(
                  children: [
                    Text(
                      '${widget.profile.displayname}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          _dialogBuilder(context);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))
                  ],
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
