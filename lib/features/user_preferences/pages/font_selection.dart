import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:matrix_chat_app/features/back_provider.dart';

class FontSelection extends StatefulWidget {
  const FontSelection({Key? key}) : super(key: key);

  @override
  State<FontSelection> createState() => _FontSelectionState();
}

class _FontSelectionState extends State<FontSelection> {
  List<String> font = [
    'Dosis',
    'MarkScript',
    'Oswald',
    'Playfair',
    'RubikPuddles',
    'DancingScript',
    'NanumPenScript',
    'GloriaHallejuah',
    'PressStart2P',
    'RubikWetPaint'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Select a Font',
            style: TextStyle(
                fontFamily: 'open sans',
                fontSize: 22,
                letterSpacing: 1.2,
                color: Colors.white70)),
      ),
      body: Consumer<BackgroundProvider>(
        builder: (context, provider, child) => ListView(children: [
          for (var i in font) ...{
            TextButton(
                onPressed: () {
                  final provider =
                      Provider.of<BackgroundProvider>(context, listen: false);
                  provider.changeFont(i);
                  Navigator.of(context).pop();
                },
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      i,
                      style: TextStyle(
                          fontFamily: i,
                          fontSize: 22,
                          color: Colors.white,
                          letterSpacing: 1.2),
                    ),
                  ),
                  Divider(height: 10, color: Colors.grey[600])
                ]))
          }
        ]),
      ),
    );
  }
}
