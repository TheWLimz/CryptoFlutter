import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth{
  static Future<User?> registerUsingEmailPassword({
   required String email,
   required String username,
   required String password
  }) async {
     FirebaseAuth auth = FirebaseAuth.instance;
     User? user; 
     try{
       UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
       user = userCredential.user;
       await user!.updateDisplayName(username);
       await user.reload();
       user = auth.currentUser;

     } on FirebaseAuthException catch(err){
       if(err.code == 'weak-password'){
   
        print('The password provided is weak, please try again');
       }
        else if (err.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
     }
     
     catch(error){
      print(error);
     }

    return user;
  }

  static Future<User?> logInUsingEmailPassword({
    required String email, 
    required String password
  }) async {
     FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}
}
