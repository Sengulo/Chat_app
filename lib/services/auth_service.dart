import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login
  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Register
  Future<String?> registerUser(String name, String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = cred.user!;
      await FirestoreService().createUser(
        UserModel(uid: user.uid, name: name, email: email),
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
