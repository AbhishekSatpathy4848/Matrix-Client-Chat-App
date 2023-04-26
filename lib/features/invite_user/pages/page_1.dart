import 'dart:async';
import 'dart:ffi';

import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
//import "package:flutter/foundatiofluttn.dart";
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MaterialApp(
    home: GenerateScreen(),
  ));
}

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 27, 253),
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
  
        _contentWidget(),
         Expanded(
      
      child: 
        Padding(
          padding: const EdgeInsets.only(bottom:4.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5 ),
              height: 60,
              width: double.infinity,
              
              child: Row(
                children: <Widget>[
                  GestureDetector(
        
                    onTap: () {},
                    
                    child: Container(
                      
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      
                    ),
                  ),
                
                  
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(221, 68, 190, 255),
                          hintText: "Enter invite link or Matrix ID",
                          hintStyle: const TextStyle(color: Color.fromARGB(119, 234, 218, 218)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),),
                    ),
                  ),
                  
                  FloatingActionButton(
                    onPressed: () {
        
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 27,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
         ),
      ],
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
        MediaQuery.of(context as BuildContext).viewInsets.bottom;
    return Container(
      color: Color.fromARGB(0, 255, 255, 255),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              bottom: _topSectionBottomPadding,
              left: 20.0,
              right: 10.0,
            ),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: QrImage(
                        data:
                            "https://www.linkedin.com/in/swati-vinayak-bhat-9b6820248"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  backgroundColor: Colors.white,
                  data: _dataString,
                  version: QrVersions.auto,
                  size: 270.0,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 01.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.share, color: Colors.white, size: 27.0),
              TextButton(
                onPressed: _captureAndSharePng,
                child: const Center(
                  child: Text(
                    'Share QR code',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: const Text(
                  'Scan QR Code',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

    

