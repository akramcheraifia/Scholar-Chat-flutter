import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendMessage({required message, required email}) {
    try {
      messages.add({'text': message, 'createdAt': DateTime.now(), 'id': email});
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromFirestore(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
