import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:share/share.dart';


class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  late String scanresult;
  GlobalKey globalKey = GlobalKey();
  final String _dataString =
      "https://www.linkedin.com/in/swati-vinayak-bhat-9b6820248";
  late TextEditingController _textController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 27, 253),
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
                    onPressed: () {},
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