import 'package:firebase_auth/firebase_auth.dart' as firebase_auth show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser{
  final bool isEmailVerified;
  final String? email;
  const AuthUser({required this.email, required this.isEmailVerified});

  factory AuthUser.fromFirebase(firebase_auth.User user){
    return AuthUser(email: user.email,isEmailVerified: user.emailVerified);
  }


}

