import 'package:flutter/material.dart';
import '../../utils/networking/http_client.dart';

class TodoListScreen extends StatefulWidget {
  final void Function() onSettingsPress;

  TodoListScreen({required this.onSettingsPress});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoListScreen> {
  dynamic myList = [];

  void initTodos() async {
    var todos = await HttpClient()
        .getData("https://jsonplaceholder.typicode.com/todos");
    setState(() {
      myList = todos;
    });
  }

  @override
  void initState() {
    super.initState();
    initTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('addTodo');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Todos'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              icon: Icon(Icons.settings), onPressed: widget.onSettingsPress)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TodoItem(
                      title: myList[index]['title'] as String,
                      completed: myList[index]['completed'] as bool,
                      toggleComplete: (value) {
                        print('toggled');
                      },
                    );
                  },
                  itemCount: myList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem(
      {Key? key,
      required this.title,
      required this.completed,
      required this.toggleComplete})
      : super(key: key);

  final String title;
  final bool completed;
  final void Function(bool?) toggleComplete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: completed,
        onChanged: toggleComplete,
      ),
      trailing: GestureDetector(
          onTap: () async {
            print('Clicked');
          },
          child: Icon(
            Icons.delete_forever_sharp,
            color: Colors.red,
          )),
      title: Text(title),
    );
  }
}
