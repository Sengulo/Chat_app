import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';
import '../services/firestore_service.dart';
import '../widgets/message_tile.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Chats Screen",
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final UserModel peerUser;
  final String currentUserId;

  const ChatScreen({required this.peerUser, required this.currentUserId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    FirestoreService().sendMessage(MessageModel(
      senderId: widget.currentUserId,
      receiverId: widget.peerUser.uid,
      text: _controller.text.trim(),
      timestamp: DateTime.now(),
    ));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.peerUser.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: FirestoreService().getMessages(widget.currentUserId, widget.peerUser.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (_, index) => MessageTile(message: messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
