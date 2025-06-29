import 'dart:convert';
import 'package:bloblist/data/repositories/tasks/task_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloblist/domain/models/task.dart';

class TaskRepositoryLocal implements TaskRepository {
  TaskRepositoryLocal();
  final String _key = 'tasks';

  @override
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_key);
    if (tasksString != null) {
      final List<dynamic> decodedList = jsonDecode(tasksString);
      return decodedList.map((item) => Task.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(tasks.map((item) => item.toJson()).toList());
    await prefs.setString(_key, encodedList);
  }
}
