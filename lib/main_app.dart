import 'package:flutter/material.dart';

import 'commom/models/app_settings.dart';
import 'commom/theme/colors/color_schemes.g.dart';
import 'features/todo_home/todo_home.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final appSettings = AppSettings.instance;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appSettings,
      builder: (context, _) {
        return MaterialApp(
          themeMode: appSettings.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          debugShowCheckedModeBanner: false,
          home: const TodoHome(),
        );
      },
    );
  }
}
