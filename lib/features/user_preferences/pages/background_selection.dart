import 'package:flutter/material.dart';
import 'package:matrix_chat_app/features/back_provider.dart';
import 'package:matrix_chat_app/features/chat/pages/user_chat.dart';
import 'package:matrix_chat_app/features/user_preferences/widgets/catalogue.dart';
import 'package:provider/provider.dart';

class BackgroundSelection extends StatefulWidget {
  const BackgroundSelection({Key? key}) : super(key: key);

  @override
  State<BackgroundSelection> createState() => _BackgroundSelectionState();
}

class _BackgroundSelectionState extends State<BackgroundSelection> {
  List<String> path = ["/assets/background_1.png","/assets/background_2.png","/assets/background_3.jpg"];
  @override
  Widget build(BuildContext context) {
  return 
  Scaffold(
    appBar: AppBar(
      title: const Text('Select a Background',
        style: TextStyle(fontFamily: 'obitron', fontSize: 20, letterSpacing: 1.4, fontWeight: FontWeight.w400, color: Colors.white70),
      ),
      backgroundColor: Colors.grey[850],
    ),
    backgroundColor: Colors.black87,
    body:Consumer<BackgroundProvider>(
      builder: (context,provider,child) => GridView.count(crossAxisCount: 3,children: [
        for(var i in path)...{
          GestureDetector(onTap: (){
              final provider = Provider.of<BackgroundProvider>(context,listen: false);
              provider.changeBackground(i);
              Navigator.of(context).pop();
          // ignore: prefer_const_constructors
          },child: Container(
            decoration: i == provider.backgroundPath  ? BoxDecoration(border: Border.all(width: 8.0))  : const BoxDecoration(),
            child: Image.asset('$i')
            )
            )
          
        }
      ]),
    ),
  );
  }
}