import 'package:firebase_auth/firebase_auth.dart';
import 'package:walletter/model/user.dart';

class FirebaseAuthenticationService {
  // Padrao singleton do Firebase
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map(
          (User user) => _userFromFirebaseUser(user),
        );
  }

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(user.uid) : null;
  }

  signInWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = authResult.user;
    return UserModel(user.uid);
  }

  createUserWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = authResult.user;
    return UserModel(user.uid);
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }
}
