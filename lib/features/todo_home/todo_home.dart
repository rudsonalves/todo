import 'package:flutter/material.dart';

import '../../commom/models/app_settings.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final appSettings = AppSettings.instance;

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
        children: [],
      ),
    );
  }
}
