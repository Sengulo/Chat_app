import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/user_tile.dart';
import '../services/firestore_service.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: FirestoreService().getUsers(), // return Stream<List<UserModel>>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found"));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, index) => UserTile(user: users[index]),
          );
        },
      ),
    );
  }
}
