import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up
  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    String res = "some erorr occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'email': email,
          'username': username,
          'bio': bio,
          'uid': cred.user!.uid,
          'followers': [],
          'following': [],
        });
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = 'the email is badly formatted.';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
