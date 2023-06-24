import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key});

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 5,
        top: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(hintText: 'Send a message'),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    var message = messageController.text;
    if (message.trim().isEmpty) {
      return;
    }
    // FocusScope.of(context).unfocus();
    User user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chats').add({
      'message': message.trim(),
      'createdAt': DateTime.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'imageUrl': userData.data()!['imageUrl'],
    });

    messageController.clear();
  }
}
