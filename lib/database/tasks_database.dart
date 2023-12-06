import '../commom/models/task_model.dart';

abstract class TasksDatabase {
  Future<List<TaskModel>> queryTasks();
  Future<int> deleteTask(TaskModel task);
  Future<int> insertTask(TaskModel task);
  Future<int> toggleTask(TaskModel task);
}
