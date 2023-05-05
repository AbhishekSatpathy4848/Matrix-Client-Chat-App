import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage(this.messageContent,this.messageType){
    this.messageContent = messageContent;
    this.messageType= messageType;
  }
}