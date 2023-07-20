class Message {
  final String? text;
  final String? id;
  Message({this.text, this.id});

  factory Message.fromFirestore(snapshot) {
    final data = snapshot;
    return Message(
      text: data['text'],
      id: data['id'],
    );
  }
}
