import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../components/download_button.dart';
=======
>>>>>>> parent of 84d4d80... Added download button

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FocusNode _focusNode;

  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  String userEmail = '';
  Gender? gender;
  Languages? language;
  bool newsletter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                onChanged: (value) {
                  userEmail = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter you email';
                  }
                  return null;
                },
              ),
              TextField(
                focusNode: _focusNode,
                decoration: InputDecoration(labelText: "Enter Search Term"),
              ),
              FormField(
                builder: (state) {
                  return Column(
                    children: [
                      RadioListTile<Gender>(
                          title: Text('Male'),
                          value: Gender.Male,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              print(state.errorText);
                              if (value != null) {
                                state.setValue(value);
                                gender = value;
                              }
                            });
                          }),
                      RadioListTile<Gender>(
                          title: Text('Female'),
                          value: Gender.Female,
                          groupValue: gender,
                          onChanged: (value) {
                            print(state.errorText);
                            setState(() {
                              if (value != null) {
                                state.setValue(value);
                                gender = value;
                              }
                            });
                          })
                    ],
                  );
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your Gender';
                  }
                  return null;
                },
              ),
              FormField(
                  validator: (value) {
                    if (value == null) {
                      print("Please select a language");
                      return "Please select a language";
                    }
                    return null;
                  },
                  builder: (state) => Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: state.value == Languages.Javascript,
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(Languages.Javascript);
                                      language = Languages.Javascript;
                                    });
                                  }),
                              Text("Javascript")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: state.value == Languages.Python,
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(Languages.Python);
                                      language = Languages.Python;
                                    });
                                  }),
                              Text("Python")
                            ],
                          )
                        ],
                      )),
              FormField(
                  builder: (state) => Column(
                        children: [
                          Row(
                            children: [
                              Switch(
                                  value: newsletter,
                                  onChanged: (value) {
                                    setState(() {
                                      newsletter = value;
                                    });
                                  }),
                              Text(
                                  """Would you like to sign up for our newsletter?""")
                            ],
                          )
                        ],
                      )),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Container(
                                height: 500,
                                child: Center(child: Text("this is a modal")),
                              ),
                            ));
                  },
                  child: Text('Show Dialog')),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}

enum Gender { Male, Female }
enum Languages {
  Javascript,
  Python,
}
