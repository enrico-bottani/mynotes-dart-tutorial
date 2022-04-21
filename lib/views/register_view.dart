import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'dart:developer' as devtools;

import 'package:mynotes/utils/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Promise to assign a value before it's used
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register"),),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration:
            InputDecoration(hintText: "Enter your email here"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
            InputDecoration(hintText: "Enter your password here"),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  UserCredential userCredential = await FirebaseAuth
                      .instance
                      .createUserWithEmailAndPassword(
                      email: email, password: password);
                  devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case 'weak-password':
                      devtools.log("Weak password");
                      await showErrorDialog(context, "Weak password");
                      break;
                    case 'email-already-in-use':
                      await showErrorDialog(context, "Email already in use");
                      devtools.log("Email already in use");
                      break;
                    case 'invalid-email':
                      await showErrorDialog(context, "Invalid email entered");
                      devtools.log("Invalid email entered");
                      break;
                  }
                  devtools.log(e.code);
                }
              },
              child: Text("Register")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                      (route) => false,
                );
              },
              child: Text("Already registered? Login here!")),
        ],
      ),
    );
  }
}