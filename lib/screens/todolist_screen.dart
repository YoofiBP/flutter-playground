import 'package:flutter/material.dart';
import 'package:new_todo_list/containers/todolist_container.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoListScreen> {
  List<Map<String, Object>> myList = [
    {'title': 'Eat food and send invoice', 'completed': true},
    {'title': 'Eat food', 'completed': true},
    {'title': 'Eat food', 'completed': true},
    {'title': 'Eat food', 'completed': true}
  ];
  @override
  Widget build(BuildContext context) {
    return TodoListContainer(
      builder: (context, viewModel) => Scaffold(
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
                icon: Icon(Icons.settings),
                onPressed: viewModel.onSettingsPress)
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
                      return ListTile(
                        leading: Checkbox(
                          value: true,
                          onChanged: (value) {
                            print('Hello');
                          },
                        ),
                        trailing: GestureDetector(
                            onTap: () {
                              print('Clicked');
                            },
                            child: Icon(Icons.delete_forever_sharp)),
                        title: Text(myList[index]['title'] as String),
                      );
                    },
                    itemCount: myList.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
