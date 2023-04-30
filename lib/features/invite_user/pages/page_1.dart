import 'dart:async';
import 'dart:ui';
import 'dart:io';
//import "package:flutter/foundatiofluttn.dart";
import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 10.0;
  static const double _topSectionBottomPadding = 5.0;
  static const double _topSectionHeight = 10.0;
  late String scanresult;

  GlobalKey globalKey = GlobalKey();
  final String _dataString =
      "https://www.linkedin.com/in/swati-vinayak-bhat-9b6820248";
  String? _inputErrorText;
  final TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    _textController.text = "matrix.to/#/@"; //default text
    super.initState();
  }

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
              _captureAndSharePng();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _contentWidget(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixStyle: const TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
                         labelText: "Enter Matrix ID or invite link",
                         prefixText: "matrix.to/#/@",
                          hintText: "useranme",
                          hintStyle: TextStyle(color:Color.fromARGB(255, 126, 124, 124)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),),
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

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary? boundary = globalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      var image = await toImage(boundary);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      Share.shareFiles([(file.path)], text: "My image");
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context as BuildContext).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Column(
      children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.only(
        //     top: _topSectionTopPadding,
        //     bottom: _topSectionBottomPadding,
        //     left: 20.0,
        //     right: 10.0,
        //   ),
        //   // ignore: sized_box_for_whitespace
        //   child: Container(
        //     height: _topSectionHeight,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
        //           child: QrImage(
        //               data:
        //                   "https://www.linkedin.com/in/swati-vinayak-bhat-9b6820248"),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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
                size: 270.0,
              ),
            ]),
          ),
        ),
        const SizedBox(height: 10.0),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Icon(Icons.share, color: Colors.white, size: 27.0),
        //     TextButton(
        //       onPressed: _captureAndSharePng,
        //       child: const Center(
        //         child: Text(
        //           'Share QR code',
        //           style: TextStyle(fontSize: 18.0),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        ElevatedButton(
          onPressed: () async {
            scanresult = (await scanner.scan())!;
            checkingValue();
            //code to open camera and start scanning,
            //the scan result is stored to "scanresult" varaible.
            setState(() {
              //refresh UI to show the result on app
            });
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

    // Share.file('ESYS AMLOG', 'amlog.png', pngBytes, 'image/png');
  }

  toImage(RenderObject? boundary) {}

  void checkingValue() {
    if (scanresult.startsWith('https://matrix.to/#/')) {
      return openMatrixToUrl();
    }
    launchUrl(scanresult as Uri);
  }

  void openMatrixToUrl() async {
    if (await canLaunchUrlString(scanresult)) {
      await launchUrlString(scanresult);
    } else {
      throw 'Could not launch $scanresult';
    }
  }
}

    


    
