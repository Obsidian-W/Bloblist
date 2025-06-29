import 'dart:convert';

import 'package:bloblist/domain/models/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloblist/l10n/app_localizations.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List<dynamic> decodedList = jsonDecode(tasksString);
      setState(() {
        _tasks = decodedList.map((item) => Task.fromJson(item)).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(_tasks.map((item) => item.toJson()).toList());
    await prefs.setString('tasks', encodedList);
  }

  void _addTask() {
    if (_controller.text.trim().isNotEmpty && _tasks.length < 5) {
      final newTodo = _controller.text.trim();
      if (newTodo.isNotEmpty) {
        setState(() {
          Task task = Task();
          task.taskName = newTodo;
          task.completed = false;
          _tasks.add(task);
        });
        _controller.clear();
        _saveTasks();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.alertTodoLimit)));
    }
  }

  void _toggleTodo(int index) {
    setState(() {
      _tasks[index].completed = !_tasks[index].completed;
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.textEnterTodo,
                    border: const OutlineInputBorder(),
                  ),
                  controller: _controller,
                  onSubmitted: (_) => _addTask(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: _addTask, child: Text(AppLocalizations.of(context)!.actionAdd)),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    _tasks[index].taskName,
                    style: TextStyle(
                      decoration: _tasks[index].completed ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  value: _tasks[index].completed,
                  onChanged: _tasks[index].completed
                      ? null
                      : (bool? value) {
                          _toggleTodo(index);
                        },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String text;
  bool completed;

  TodoItem({required this.text, required this.completed});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(text: json['text'], completed: json['completed']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'completed': completed};
  }
}
