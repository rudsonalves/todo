import '../commom/models/task_model.dart';
import 'task_database.dart';

class MockSqlTaskRepository implements TaskDatabase {
  final _tasks = <TaskModel>[];

  List<TaskModel> get tasks => _tasks;

  @override
  Future<List<TaskModel>> queryTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    _tasks.clear();

    for (int index = 0; index < 10; index++) {
      _tasks.add(
        TaskModel(
          id: index,
          description: 'My task $index',
        ),
      );
    }
    return _tasks;
  }

  @override
  Future<int> insertTask(TaskModel task) async {
    await Future.delayed(const Duration(seconds: 1));
    _tasks.add(task);
    return 1;
  }

  @override
  Future<int> deleteTask(TaskModel task) async {
    await Future.delayed(const Duration(seconds: 1));
    _tasks.remove(task);
    return 1;
  }

  @override
  Future<int> toggleTask(TaskModel task) async {
    await Future.delayed(const Duration(seconds: 1));
    int index = _tasks.indexOf(task);

    if (index == -1) return -1;

    task.isDone = task.isDone ? false : true;
    _tasks[index] = task;

    return 1;
  }

  @override
  Future<void> init() async {}
}
