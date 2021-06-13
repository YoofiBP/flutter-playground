import 'package:flutter/material.dart';
import '../../models/todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.updateTodo,
      required this.deleteTodo})
      : super(key: key);

  final Todo todo;
  final void Function(Todo) updateTodo;
  final void Function(int id) deleteTodo;

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final FocusNode _focusNode;
  bool isEditing = false;
  String title = '';

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    _focusNode = FocusNode();
    _focusNode.addListener(handleFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void handleFocusChange() {
    if (_focusNode.hasFocus == false && isEditing) {
      //if change to title has occured save
      if (widget.todo.title != title) {
        widget.todo.todoTitle = title;

        //save todo
        widget.updateTodo(widget.todo);
      }

      setState(() {
        isEditing = false;
      });
    }
  }

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (_) {
          widget.todo.toggleComplete();
          widget.updateTodo(widget.todo);
        },
      ),
      trailing: IconButton(
          icon: Icon(Icons.delete_forever_sharp),
          onPressed: () {
            widget.deleteTodo(widget.todo.id);
          }),
      title: TextFormField(
        onTap: () {
          setState(() {
            isEditing = true;
          });
        },
        onChanged: (value) {
          title = value;
        },
        focusNode: _focusNode,
        readOnly: !isEditing,
        initialValue: title,
        decoration: InputDecoration(
            border: isActive
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 5,
                        style: BorderStyle.solid,
                        color: Colors.black))
                : InputBorder.none),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
