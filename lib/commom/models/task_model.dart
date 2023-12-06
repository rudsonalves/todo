class TaskModel {
  int? id;
  String description;
  bool isDone;

  TaskModel({
    this.id,
    required this.description,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, description: $description, isDone: $isDone)';
  }
}
