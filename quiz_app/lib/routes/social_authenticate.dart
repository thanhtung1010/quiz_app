import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthenticate {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    String uid = auth.currentUser.uid;
    Map<String, dynamic> usersMap = {
      "email": googleUser.email,
      "name": googleUser.displayName,
      "isAdmin": false,
    };
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(usersMap)
        .catchError((e) {
      if (!e) {
        print('add user success');
      } else {
        print(e.toString());
      }
    });
  }
}
