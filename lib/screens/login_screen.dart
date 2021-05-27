import 'package:flutter/material.dart';
import '../containers/login_container.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoginContainer(
      builder: (context, viewModel) => Scaffold(
        backgroundColor: Colors.white,
        body: Form(
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
                        child: viewModel.isBusy
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: viewModel.loginAction,
                                child: Text('Login')),
                      )),
                    ],
                  )
                ],
              ),
            ),
            key: _formKey),
      ),
    );
  }
}
