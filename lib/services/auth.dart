import 'package:circlink/modals/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _appUserFromFirebase(User? user) {
    return user != null ? AppUser(userId: user.uid) : null;
  }

  User? getUser() {
    var user = _auth.currentUser;

    if (user != null) {
      // User is signed in.
    } else {
      // No user is signed in.
    }
    return user;
  }

  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      // Log In attempt
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // return _appUserFromFirebase(user);
      return null;
    } catch (e) {
      switch (e.toString()) {
        case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
          return "The password is invalid or the user does not have a password.";
        case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
          return "There is no user record corresponding to this identifier. The user may have been deleted.";
        default:
          return "Log in error";
      }
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      // Register attempt
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // return _appUserFromFirebase(user);
      return null;
    } catch (e) {
      switch (e.toString()) {
        case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
          return "The email address is already in use by another account.";
        default:
          return "Register error";
      }
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future logOut() async {
    try {
      // Logout attempt
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteAccount(String email, String password) async {
    User? user = _auth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);

    await user!.reauthenticateWithCredential(credential).then((value) {
      value.user!.delete().then((response) {
        // What happens after user is deleted
      });
    });
  }
}
