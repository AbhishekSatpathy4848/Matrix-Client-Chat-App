import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:matrix_chat_app/features/chat/chat_class.dart';

class Convo extends StatefulWidget {
  final Client client;
  final Room room;
  const Convo({super.key, required this.client, required this.room});

  @override
  State<Convo> createState() => _ConvoState();
}

class _ConvoState extends State<Convo> {
  late final Future<Timeline> _timelineFuture;
  final TextEditingController _sendController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int _count = 0;

  initTimeLine() {
    _timelineFuture = widget.room.getTimeline(
        onChange: (i) {
          _listKey.currentState?.setState(() {});
        },
        onInsert: (i) {
          _listKey.currentState?.insertItem(i);
          _count++;
        },
        onRemove: (i) {
          _count--;
          _listKey.currentState?.removeItem(i, (_, __) => const ListTile());
        },
        onUpdate: () {});
  }

  void _send() async {
    if (_sendController.text.trim().isEmpty) return;
    await widget.room.sendTextEvent(_sendController.text.trim());
    _sendController.clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initTimeLine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          title: Row(
            children: <Widget>[
              const CircleAvatar(
                backgroundImage: null,
                maxRadius: 22,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.room.getLocalizedDisplayname(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  // Text(
                  //   widget.client.getPresence(widget.client.userID!),
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 13,
                  //   ),
                  // )
                ],
              )),
              const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ],
          ),
        ),
        body: FutureBuilder<Timeline>(
            future: _timelineFuture,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              _count = snapshot.data!.events.length;
              return Column(
                children: [
                  Expanded(
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: snapshot.data!.events.length,
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index, animation) {
                        // debugPrint("Asds ${snapshot.data!.events[index].body}");
                        return ScaleTransition(
                          scale: animation,
                          child: Opacity(
                            opacity: snapshot.data!.events[index].status.isSent
                                ? 1
                                : 0.5,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 5, bottom: 5),
                              child: Align(
                                alignment:
                                    (snapshot.data!.events[index].senderId !=
                                            widget.client.userID
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: snapshot
                                                .data!
                                                .events[index]
                                                .senderFromMemoryOrFallback
                                                .id ==
                                            widget.client.userID
                                        ? Colors.blueAccent
                                        : Colors.grey[900],
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    snapshot.data!.events[index].body.trim(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 10, top: 10),
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
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextField(
                                    controller: _sendController,
                                    cursorColor: Colors.white,
                                    decoration: const InputDecoration(
                                      hintText: "Type here...",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      border: InputBorder.none,
                                    ),
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              FloatingActionButton(
                                onPressed: _send,
                                backgroundColor: Colors.blueAccent,
                                elevation: 0,
                                child: const Icon(Icons.send,
                                    color: Colors.white, size: 18),
                              )
                            ],
                          )))
                ],
              );
            }));
  }
}
