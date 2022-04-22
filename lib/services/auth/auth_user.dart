import 'package:firebase_auth/firebase_auth.dart' as f show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser{
  final bool isEmailVerified;

  const AuthUser(this.isEmailVerified);

  factory AuthUser.fromFirebase(f.User user){
    return AuthUser(user.emailVerified);
  }


}

