import 'package:firebase_auth/firebase_auth.dart' as firebase_auth show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser{
  final bool isEmailVerified;

  const AuthUser({required this.isEmailVerified});

  factory AuthUser.fromFirebase(firebase_auth.User user){
    return AuthUser(isEmailVerified: user.emailVerified);
  }


}

