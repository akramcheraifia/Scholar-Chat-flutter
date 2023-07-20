import 'package:flutter/material.dart';

import '../models/message.dart';
import 'constants.dart';

class ChatBubbleSender extends StatelessWidget {
  ChatBubbleSender({
    Key? key,
    required this.message,
  });
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30))),
        child: Text(message.text as String,
            style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ChatBubbleReciver extends StatelessWidget {
  ChatBubbleReciver({
    Key? key,
    required this.message,
  });
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(30))),
        child: Text(message.text as String,
            style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
