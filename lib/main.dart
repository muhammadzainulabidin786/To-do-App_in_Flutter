import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoApp(),
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final TextEditingController _taskController = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

// Method for adding the task
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({'task': _taskController.text, 'isCompleted': false});
        _taskController.clear();
      });
    }
  }

// Method for the deleting the task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

//Method for the toggle

  void _toggleTaskCompletion(int index) {
    setState(
      () {
        _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'What do you need to do?',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                    onPressed: _addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 100, color: Colors.grey),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "No Task Yet",
                          style: TextStyle(fontSize: 20.0, color: Colors.grey),
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: _tasks[index]['isCompleted'],
                              onChanged: (value) =>
                                  _toggleTaskCompletion(index),
                              activeColor: Colors.teal,
                            ),
                            title: Text(
                              _tasks[index]['task'],
                              style: TextStyle(
                                fontSize: 18.0,
                                decoration: _tasks[index]['isCompleted']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: _tasks[index]['isCompleted']
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "Added on: ${_tasks[index]['timestamp']}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => _deleteTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
