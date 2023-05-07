// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:matrix_chat_app/features/chat/pages/user_chat.dart';
import 'package:matrix_chat_app/features/invite_user/pages/page_1.dart';
import 'package:matrix_chat_app/features/user_preferences/pages/page_1.dart';

class ChatHomePage extends StatefulWidget {
  final Client client;
  const ChatHomePage({
    super.key,
    required this.client,
  });

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  late Client client;
  late ProfileInformation profile;

  void _getProfile() async {
    profile = await client.getUserProfile(client.userID!);
    profile.avatarUrl;
    profile.displayname;
  }

  @override
  Widget build(BuildContext context) {
    _getProfile();
    return Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Text('MatChat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Settings(
                              client: widget.client,
                              profile: profile,
                            );
                          }));
                        },
                        icon: Icon(
                          Icons.person_2_rounded,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            )),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return GenerateScreen();
                }));
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Convo();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: null,
                          radius: 25,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rick Astley',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text('Never gonna give you up',
                                style: TextStyle(
                                  color: Colors.grey[300],
                                ))
                          ],
                        )
                      ],
                    ),
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
