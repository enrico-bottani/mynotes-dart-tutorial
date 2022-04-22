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
      appBar: AppBar(
        title: Text("Verify email"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("We've sent you an email verification to: ${currentUser?.email}."),
        Text("Please open it to verify your account"),
        Center(
          child: TextButton(
              onPressed: () async {
                await currentUser?.sendEmailVerification();
              },
              child: const Text("Send email verification again")),
        ),
        Center(
          child: TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute, (route) => false);
              },
              child: const Text("Restart")),
        ),
      ]),
    );
  }
}
