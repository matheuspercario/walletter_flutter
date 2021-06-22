import 'package:firebase_auth/firebase_auth.dart';
import 'package:walletter/data/firestore_database.dart';
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

  createUserWithEmailAndPassword({
    String fullName,
    String email,
    String password,
    var dependents,
    var creditCard,
    var idade,
    var rendaMensal,
    var hasCasa,
    var hasCarro,
    var hasMoto,
    var hasBicicleta,
  }) async {
    UserCredential authResult =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = authResult.user;

    // Invocar Firestore para inserir informacoes a mais...
    FirestoreRemoteServer.helper.includeUserData(
      user.uid,
      fullName,
      email,
      dependents,
      creditCard,
      idade,
      rendaMensal,
      hasCasa,
      hasCarro,
      hasMoto,
      hasBicicleta,
    );

    return UserModel(user.uid);
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }
}
