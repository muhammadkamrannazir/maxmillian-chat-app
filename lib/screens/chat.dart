// ignore_for_file: unused_local_variable

import 'package:chat/widget/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found'),
          );
        }
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        var loadedMessages = chatSnapshots.data!.docs;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            itemCount: loadedMessages.length,
            itemBuilder: (c, index) {
              final chatMessage = loadedMessages[index].data();
              final nextChatMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1].data()
                  : null;
              final currentMessageUserId = chatMessage['userId'];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['userId'] : null;
              if (currentMessageUserId == nextMessageUserId) {
                return MessageBubble.next(
                  message: chatMessage['message'],
                  isMe: authenticatedUser.uid == currentMessageUserId,
                );
              } else {
                MessageBubble.first(
                  userImage: chatMessage['imageUrl'],
                  username: chatMessage['username'],
                  message: chatMessage['message'],
                  isMe: authenticatedUser.uid == nextMessageUserId,
                );
              }
            },
          ),
        );
      },
    );
  }
}
