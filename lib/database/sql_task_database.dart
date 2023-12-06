import '../commom/models/task_model.dart';
import 'tasks_database.dart';

class SqlTaskDatabase implements TasksDatabase {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  @override
  Future<int> deleteTask(TaskModel task) async {
    bool resp = _tasks.remove(task);
    // await Future.delayed(const Duration(seconds: 1));
    return resp ? 1 : -1;
  }

  @override
  Future<int> insertTask(TaskModel task) async {
    _tasks.add(task);
    // await Future.delayed(const Duration(seconds: 1));
    return 1;
  }

  @override
  Future<List<TaskModel>> queryTasks() async {
    _tasks.clear();

    for (int i = 0; i < 8; i++) {
      _tasks.add(
        TaskModel(
          id: i,
          description: 'My task $i',
        ),
      );
    }
    // await Future.delayed(const Duration(seconds: 1));
    return _tasks;
  }

  @override
  Future<int> toggleTask(TaskModel task) async {
    task.isDone = task.isDone == true ? false : true;
    // await Future.delayed(const Duration(seconds: 1));
    return 1;
  }
}
