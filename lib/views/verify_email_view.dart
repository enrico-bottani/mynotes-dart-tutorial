import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("Please verify your email address: ${currentUser?.email}"),
        TextButton(
            onPressed: () async {
              await currentUser?.sendEmailVerification();
            },
            child: const Text("Send email verification")),
        TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
            },
            child: const Text("Sign Out")),
      ]),
    );
  }
}