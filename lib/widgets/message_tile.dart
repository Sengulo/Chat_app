import 'package:flutter/material.dart';
import '../models/message_model.dart';

class MessageTile extends StatelessWidget {
  final MessageModel message;

  const MessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = true; // You can pass currentUserId to determine alignment

    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isMe ? Colors.deepPurple : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(12),
        child: Text(
          message.text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
