import 'package:flutter/foundation.dart';

import '../../commom/models/task_model.dart';
import '../../data/sqflite_repository.dart';
import 'todo_home_state.dart';

class TodoHomeController extends ChangeNotifier {
  TodoHomeState _state = TodoHomeStateInitial();

  TodoHomeState get state => _state;

  final _taskRepository = SqfliteRepository(); //MockSqlTaskRepository();

  List<TaskModel> get tasks => _taskRepository.tasks;

  void _changeState(TodoHomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> init() async {
    await _taskRepository.init();
    queryTask();
  }

  Future<void> queryTask() async {
    _changeState(TodoHomeStateLoading());
    try {
      await _taskRepository.queryTasks();
      _changeState(TodoHomeStateSuccess());
    } catch (err) {
      _changeState(TodoHomeStateError());
    }
  }

  Future<void> insertTask(TaskModel task) async {
    _changeState(TodoHomeStateLoading());
    try {
      await _taskRepository.insertTask(task);
      _changeState(TodoHomeStateSuccess());
    } catch (err) {
      _changeState(TodoHomeStateError());
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    _changeState(TodoHomeStateLoading());
    try {
      await _taskRepository.deleteTask(task);
      _changeState(TodoHomeStateSuccess());
    } catch (err) {
      _changeState(TodoHomeStateError());
    }
  }

  Future<void> toggleTask(TaskModel task) async {
    _changeState(TodoHomeStateLoading());
    try {
      await _taskRepository.toggleTask(task);
      _changeState(TodoHomeStateSuccess());
    } catch (err) {
      _changeState(TodoHomeStateError());
    }
  }
}
