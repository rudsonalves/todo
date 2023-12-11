abstract class Helper {
  Future<void> init();
  Future<void> restartTables();
  // task Table
  Future<int> insertTask(Map<String, Object?> taskMap);
  Future<List<Map<String, Object?>?>?> queryTasks();
  Future<Map<String, Object?>?> queryTaskId(int id);
  Future<int> updateTask(Map<String, Object?> taskMap);
  Future<int> updateTaskIsDone(int id, bool isDone);
  Future<int> deleteTask(int id);
}
