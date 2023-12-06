import 'package:flutter/material.dart';

import '../../commom/models/app_settings.dart';
import '../../commom/models/task_model.dart';
import 'todo_home_controller.dart';
import 'todo_home_state.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final appSettings = AppSettings.instance;
  final taskController = TextEditingController();
  final todoController = TodoHomeController();

  @override
  void initState() {
    super.initState();
    todoController.init();
  }

  void _insertTask() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.unfocus();

    if (taskController.text.isEmpty) return;

    final task = TaskModel(
      description: taskController.text,
    );

    todoController.insertTask(task);

    taskController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: appSettings.toggleTheme,
            icon: ListenableBuilder(
              listenable: appSettings,
              builder: (context, _) {
                return Icon(
                  (appSettings.themeMode == ThemeMode.light)
                      ? Icons.light_mode
                      : Icons.dark_mode,
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListenableBuilder(
            listenable: todoController,
            builder: (context, _) {
              if (todoController.state is TodoHomeStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (todoController.state is TodoHomeStateSuccess) {
                final tasks = todoController.tasks;

                return Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Checkbox(
                        value: tasks[index].isDone,
                        onChanged: (value) =>
                            todoController.toggleTask(tasks[index]),
                      ),
                      title: Text(tasks[index].description),
                      trailing: IconButton(
                        onPressed: () =>
                            todoController.deleteTask(tasks[index]),
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Ocorreu um erro!'),
                );
              }
            },
          ),
          ListTile(
            leading: IconButton(
              onPressed: _insertTask,
              icon: const Icon(Icons.send),
            ),
            title: TextField(
              controller: taskController,
              onEditingComplete: _insertTask,
            ),
          ),
        ],
      ),
    );
  }
}
