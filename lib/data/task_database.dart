import '../commom/models/task_model.dart';

abstract class TaskDatabase {
  Future<List<TaskModel>> queryTasks();
  Future<int> insertTask(TaskModel task);
  Future<int> deleteTask(TaskModel task);
  Future<int> toggleTask(TaskModel task);
}
