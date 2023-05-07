import 'package:flutter/material.dart';
import 'package:matrix_chat_app/features/chat/chat_class.dart';

class Convo extends StatelessWidget {
  Convo({Key? key}) : super(key: key);

  final List<ChatMessage> messages = [
    ChatMessage("Hello, Druv", "receiver"),
    ChatMessage("How have you been?", "receiver"),
    ChatMessage("Hey Criss, I'm fine. wbu", "sender"),
    ChatMessage("ehh, doing good", "receiver"),
    ChatMessage("Where are you?", "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/002/002/403/original/man-with-beard-avatar-character-isolated-icon-free-vector.jpg"),
                maxRadius: 22,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Criss',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  )
                ],
              )),
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ],
          ),
        ),
        body: Stack(children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.blueGrey
                          : Colors.blue),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.grey[900],
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: "Type here...",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.send, color: Colors.white, size: 18),
                        backgroundColor: Colors.blueAccent,
                        elevation: 0,
                      )
                    ],
                  )))
        ]));
  }
}
