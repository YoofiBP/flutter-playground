import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../utils/auth/auth.dart';
import '../utils/state_management/redux/models/app_state.dart';

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
    if (appAuth.isLoggedIn) {
      Navigator.pushNamed(context, '/todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.create(store),
        builder: (context, viewModel) => SafeArea(
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
                          child: viewModel.isBusy
                              ? CircularProgressIndicator()
                              : viewModel.isLoggedIn
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
      ),
    );
  }
}

class ViewModel {
  final bool isBusy;
  final bool isLoggedIn;

  ViewModel({required this.isBusy, required this.isLoggedIn});

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
        isBusy: store.state.authState.isBusy,
        isLoggedIn: store.state.authState.isLoggedIn);
  }
}
