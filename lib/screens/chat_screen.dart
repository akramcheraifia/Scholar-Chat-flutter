import 'package:chatapp/components/constants.dart';
import 'package:flutter/material.dart';

import '../components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static String id = "chat_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Chat'),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const ChatBubble();
        },
      ),
    );
  }
}
