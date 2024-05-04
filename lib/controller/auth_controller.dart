import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  var isLoading = false.obs;
  late Stream<User?> _authStateChanges;

  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  void initAuth() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      _auth = FirebaseAuth.instance;
      _authStateChanges = _auth.authStateChanges();
      _authStateChanges.listen((user) {
        _user.value = user;
      });
    });
  }

  User? getUser() => _auth.currentUser;

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['email']).signIn().catchError((_) => setProgress(false));
      if (googleUser != null) {
        setProgress(true);
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (error) {
      setProgress(false);
    }
  }

  Future<void> signOut() async {
    try {
      setProgress(false);
      await GoogleSignIn(scopes: ['email']).signOut();
      await _auth.signOut();
    } catch (error) {
      debugPrint('SignOut error $error');
    }
  }

  setProgress(bool val) {
    isLoading.value = val;
  }
}
