import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart' as Routes;
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_service.dart';
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
  late bool _loginButtonEnabled;
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    _loginButtonEnabled = false;
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
      var userCredential =
      await AuthService.firebase().logIn(email: email, password: password);
      devtools.log(userCredential.toString());
      final user = AuthService
          .firebase()
          .currentUser;
      if (user?.isEmailVerified ?? false) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.notesRoute,
              (route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.verifyEmailRoute,
              (route) => false,
        );
      }
    } on UserNotFoundAuthException catch (e) {
      await showErrorDialog(context, "User not found");
    } on WrongPasswordAuthException catch (e) {
      await showErrorDialog(context, "Wrong password");
    } on InvalidEMailAuthException catch (e) {
      await showErrorDialog(context, "Invalid email");
    } catch (e) {
      await showErrorDialog(context, "Generic Error");
    }
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Enter your email here"),
              onChanged: (String text) {
                devtools.log("Enabled");
                setState(() {
                  _loginButtonEnabled = text.isNotEmpty?true:false;
                });
              },
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(hintText: "Enter your password here"),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
                onPressed: _loginButtonEnabled?onLoginButtonPress:null,
                child: Text("Login")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.registerRoute,
                        (route) => false,
                  );
                },
                child: Text("Not registered yet? Register here!")),
          ],
        ),
      ),
    );
  }
}
