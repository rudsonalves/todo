import '../commom/models/task_model.dart';
import 'database/sqflite_helper.dart';
import 'task_database.dart';

class SqfliteRepository implements TaskDatabase {
  final helper = SqfliteHelper.instance;

  final _tasks = <TaskModel>[];

  List<TaskModel> get tasks => _tasks;

  @override
  Future<void> init() async {
    await helper.init();
  }

  @override
  Future<int> insertTask(TaskModel task) async {
    final id = await helper.insertTask(task.toMap());
    task.id = id;
    await queryTasks();
    return id;
  }

  @override
  Future<List<TaskModel>> queryTasks() async {
    _tasks.clear();
    final maps = await helper.queryTasks();
    if (maps != null) {
      for (final map in maps) {
        if (map != null) {
          _tasks.add(TaskModel.fromMap(map));
        }
      }
    }

    return _tasks;
  }

  @override
  Future<int> deleteTask(TaskModel task) async {
    if (task.id == null) {
      throw Exception('deleteTask: task id is null');
    }
    final result = await helper.deleteTask(task.id!);
    await queryTasks();
    return result;
  }

  @override
  Future<int> toggleTask(TaskModel task) async {
    final result = await helper.updateTaskIsDone(task.id!, !task.isDone);
    await queryTasks();
    return result;
  }
}
