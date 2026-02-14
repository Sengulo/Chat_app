import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;

  const UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple,
        child: Text(user.name[0].toUpperCase()),
      ),
      title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(user.email),
      trailing: Icon(Icons.message, color: Colors.deepPurple),
      onTap: () {
        // Navigate to ChatScreen with this user
        Navigator.pushNamed(context, '/chat', arguments: user);
      },
    );
  }
}
