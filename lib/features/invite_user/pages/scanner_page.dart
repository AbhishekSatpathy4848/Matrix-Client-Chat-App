import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:share/share.dart';

class GenerateScreen extends StatefulWidget {
  final Client client;
  const GenerateScreen({required this.client, super.key});

  @override
  State<StatefulWidget> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  late String scanresult;
  GlobalKey globalKey = GlobalKey();
  late String _dataString;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final client = Provider.of<Client>(context, listen: false);
    _dataString = "https://matrix.to/#/${client.userID!}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Scan QR Code'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(_dataString, subject: 'Look what I made!');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _contentWidget(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _textController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        labelText: "Enter Matrix ID or invite link",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixText: "matrix.to/#/@",
                        hintText: "useranme",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 126, 124, 124)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      createRoomWithUser(_textController.text, widget.client)
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context as BuildContext).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              QrImage(
                backgroundColor: Colors.white,
                data: _dataString,
                version: QrVersions.auto,
                size: 250.0,
              ),
            ]),
          ),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () async {
            scanresult = (await scanner.scan())!;
            _textController.text =
                scanresult.substring(scanresult.indexOf('@') + 1);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          child: const Text(
            'Scan QR Code',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

Future createRoomWithUser(String userId, Client client) async {
  await client.createRoom(invite: ["@$userId"]);
  return;
}
