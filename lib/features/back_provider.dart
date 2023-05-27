import 'package:flutter/material.dart';

class BackgroundProvider extends ChangeNotifier{
  String? backgroundPath; String? chatfont;
  BackgroundProvider({required this.backgroundPath, required this.chatfont});

  void changeBackground(String path){
    backgroundPath = path;
    notifyListeners();
  }

  void changeFont (String font) {
    chatfont = font;
    notifyListeners();
  }
}