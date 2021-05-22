import 'package:flutter/material.dart';
import '../utils/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formFields = {'email': '', 'password': ''};

  void refresh() {
    setState(() {});
  }

  AppAuth appAuth = AppAuth();

  @override
  void initState() {
    super.initState();
    appAuth.initAction();
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      print(formFields['email']);
      print(formFields['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                        child: appAuth.isBusy
                            ? CircularProgressIndicator()
                            : appAuth.isLoggedIn
                                ? Text('Logged In')
                                : ElevatedButton(
                                    onPressed: () => {
                                      setState(() {
                                        appAuth.loginAction(refresh);
                                      })
                                    },
                                    child: Text('Login'),
                                  ),
                      ))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
