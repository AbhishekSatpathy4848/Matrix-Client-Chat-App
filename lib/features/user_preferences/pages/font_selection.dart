import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:matrix_chat_app/features/back_provider.dart';

class FontSelection extends StatefulWidget {
  const FontSelection({Key? key}) : super(key: key);

  @override
  State<FontSelection> createState() => _FontSelectionState();
}

class _FontSelectionState extends State<FontSelection> {

  List font  = ['Dosis','MarkScript','Oswald', 'Playfair', 'RubikPuddles'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Select a Font',
        style: TextStyle(fontFamily: 'obitron', fontSize: 20, letterSpacing: 1.4 , color: Colors.white70)),
      ),
      body:Consumer<BackgroundProvider>(
      builder: (context,provider,child) => GridView.count(crossAxisCount: 3,children: [
        for(var i in font)...{
          GestureDetector(onTap: (){
              final provider = Provider.of<BackgroundProvider>(context,listen: false);
              provider.changeFont(i);
              Navigator.of(context).pop();
          // ignore: prefer_const_constructors
          },child: Container(
            decoration: i == provider.backgroundPath  ? BoxDecoration(border: Border.all(width: 8.0), color: Colors.white )  : const BoxDecoration(),
            child: Text ('$i' ,
            style: TextStyle(fontFamily: '$i', fontSize: 10, color: Colors.white, letterSpacing: 1.3),
            )
            )
            )
          
        }
      ]),
    ),
    );
  }
}
