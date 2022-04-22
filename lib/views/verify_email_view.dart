import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_service.dart';

import '../constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final currentUser = AuthService.firebase().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify email"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("We've sent you an email verification"),
        Text("Please open it to verify your account"),
        Center(
          child: TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text("Send email verification again")),
        ),
        Center(
          child: TextButton(
              onPressed: () async {
                await AuthService.firebase().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute, (route) => false);
              },
              child: const Text("Restart")),
        ),
      ]),
    );
  }
}
