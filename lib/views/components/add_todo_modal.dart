import 'package:flutter/material.dart';

class AddTodoModal extends StatefulWidget {
  const AddTodoModal({Key? key, required this.saveTodo}) : super(key: key);

  final void Function(String todoTitle) saveTodo;

  @override
  _AddTodoModalState createState() => _AddTodoModalState();
}

class _AddTodoModalState extends State<AddTodoModal> {
  final _formKey = GlobalKey<FormState>();

  String todoTitle = '';

  void setTitle(String title) {
    setState(() {
      todoTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: setTitle,
                decoration: const InputDecoration(
                    hintText: 'What you gotta do?',
                    hintStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.saveTodo(todoTitle);
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
