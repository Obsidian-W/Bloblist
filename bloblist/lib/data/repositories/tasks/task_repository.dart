import 'package:bloblist/domain/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> loadTasks();
  //Save user's task
  Future<void> saveTasks(List<Task> tasks);
}
