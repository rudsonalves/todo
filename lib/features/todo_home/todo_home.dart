import 'package:flutter/material.dart';
import 'package:todo/database/sql_task_database.dart';

import '../../commom/models/task_model.dart';
import '../../commom/models/app_settings.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final appSettings = AppSettings.instance;
  final descriptionController = TextEditingController();
  final taskData = SqlTaskDatabase();

  @override
  void initState() {
    super.initState();

    taskData.queryTasks();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void _newTask() {
    if (descriptionController.text.isNotEmpty) {
      taskData.insertTask(
        TaskModel(description: descriptionController.text),
      );
      descriptionController.text = '';

      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  void _deleteTask(TaskModel task) {
    setState(() {
      taskData.deleteTask(task);
    });
  }

  void _toggleTask(TaskModel task) {
    setState(() {
      taskData.toggleTask(task);
    });
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
          Expanded(
            child: ListView.builder(
              itemCount: taskData.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: taskData.tasks[index].isDone,
                    onChanged: (bool? value) =>
                        _toggleTask(taskData.tasks[index]),
                  ),
                  title: Text(taskData.tasks[index].description),
                  trailing: IconButton(
                    onPressed: () => _deleteTask(taskData.tasks[index]),
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                    ),
                  ),
                );
              },
            ),
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.send),
              onPressed: _newTask,
            ),
            title: TextField(
              controller: descriptionController,
              onEditingComplete: _newTask,
            ),
          ),
        ],
      ),
    );
  }
}
