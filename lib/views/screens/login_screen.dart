import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final bool isBusy;
  final void Function() loginAction;

  static const routeName = '/';

  LoginScreen({required this.isBusy, required this.loginAction});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Scaffold(
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
                        child: widget.isBusy
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: widget.loginAction,
                                child: Text(
                                    AppLocalizations.of(context)?.helloWorld ??
                                        'Login')),
                      )),
                    ],
                  )
                ],
              ),
            ),
            key: _formKey),
      );
}
