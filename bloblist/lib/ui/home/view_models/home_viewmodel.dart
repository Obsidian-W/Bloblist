import 'package:bloblist/data/repositories/tasks/task_repository.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloblist/domain/models/task.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required UserRepository userRepository, required TaskRepository taskRepository})
    : _userRepository = userRepository,
      _taskRepository = taskRepository {
    loadTasks();
  }

  final UserRepository _userRepository;
  final TaskRepository _taskRepository;
  List<Task> tasks = [];

  Future<void> logout(BuildContext context) async {
    await context.read<AuthRepository>().logout();
  }

  Future<void> loadTasks() async {
    tasks = await _taskRepository.loadTasks();
    notifyListeners();
  }

  Future<bool> addTask(String taskName) async {
    if (taskName.trim().isNotEmpty && tasks.length < 5) {
      Task task = Task(taskName.trim(), false);
      tasks.add(task);
      await _taskRepository.saveTasks(tasks);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> toggleTask(int index) async {
    tasks[index].completed = !tasks[index].completed;
    await _taskRepository.saveTasks(tasks);

    //Update blob with new stats and do the necessary calculations for level up + animations
    notifyListeners();
  }
}
