import 'package:chatapp/components/constants.dart';
import 'package:chatapp/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/chat_cubit/chat_cubit.dart';
import '../components/chat_bubble.dart';
import '../cubit/register_cubit/register_cubit.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = "chat_screen";
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];
  final listViewScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
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
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: listViewScrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBubbleSender(message: messagesList[index])
                        : ChatBubbleReciver(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                controller.clear();
                listViewScrollController.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                suffixIcon: const Icon(Icons.send),
                suffixIconColor: kPrimaryColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: kPrimaryColor, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: kPrimaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
