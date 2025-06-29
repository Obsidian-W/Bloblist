import 'package:bloblist/data/repositories/tasks/task_repository.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/blob.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloblist/domain/models/task.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required UserRepository userRepository, required TaskRepository taskRepository})
    : _userRepository = userRepository,
      _taskRepository = taskRepository {
    loadTasks();
    loadBlob();
  }

  final UserRepository _userRepository;
  final TaskRepository _taskRepository;
  List<Task> tasks = [];
  Blob blob = Blob();
  bool _levelUpTriggered = false;
  bool get justLeveledUp => _levelUpTriggered; //For UI to know if the blob just leveled up

  Future<void> loadBlob() async {
    blob = await _userRepository.getBlob();
    notifyListeners();
  }

  Future<void> loadTasks() async {
    tasks = await _taskRepository.loadTasks();
    notifyListeners();
  }

  Future<bool> addTask(String taskName) async {
    if (taskName.trim().isNotEmpty && tasks.length < 5) {
      Task task = Task(taskName.trim(), false);
      task.xp = 15; // Default XP for new tasks (should be 1)
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
    blob.xp += tasks[index].xp;
    blob.agility += tasks[index].agility;
    blob.strength += tasks[index].strength;
    blob.mind += tasks[index].mind;
    blob.charisma += tasks[index].charisma;
    blob.willpower += tasks[index].willpower;

    bool leveledUp = false;

    while (blob.xp >= 10) {
      blob.xp -= 10;
      blob.level += 1;
      leveledUp = true;
    }

    //Play the animation only once
    /*
    if (leveledUp && !_levelUpTriggered) {
      _levelUpTriggered = true;
    }*/

    await _userRepository.saveBlob(blob: blob);
    notifyListeners();
  }

  /// Make sure to call this method after handling the level up animation and sound
  void levelUpHandled() {
    _levelUpTriggered = false;
  }

  Future<void> logout(BuildContext context) async {
    await context.read<AuthRepository>().logout();
  }
}
