import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utils/show_error_dialog.dart';
import 'dart:developer' as devtools;
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  onLoginButtonPress() async {
    final email = _email.text;
    final password = _password.text;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      devtools.log(userCredential.toString());
      Navigator.of(context).pushNamedAndRemoveUntil(
        notesRoute,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // specialized catch black
      switch (e.code) {
        case 'user-not-found':
          devtools.log("User not found");
          await showErrorDialog(context, "User not found");
          break;
        case 'invalid-email':
          devtools.log("Invalid email");
          await showErrorDialog(context, "Invalid email");
          break;
        case 'wrong-password':
          devtools.log("Wrong password");
          await showErrorDialog(context, "Wrong credentials");
          break;
        default:
          devtools.log("Something else happend");
          await showErrorDialog(context, "Unknown error");
          devtools.log(e.code);
          break;
      }
    }catch(e){
      devtools.log("Something else happend");
      await showErrorDialog(context, "Error: ${e.toString()}");
      devtools.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Enter your email here"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(hintText: "Enter your password here"),
          ),
          TextButton(onPressed: onLoginButtonPress, child: Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: Text("Not registered yet? Register here!")),
        ],
      ),
    );
  }
}


