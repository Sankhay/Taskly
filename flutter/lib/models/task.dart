class Task {
  String id;
  String title;
  String description;
  String taskHour;
  String taskDay;
  String? userId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.taskHour,
    required this.taskDay,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      taskHour: json['taskHour'].substring(0, 5),
      taskDay: json['taskDay']
    );
  }
}

class TaskDTO {
  String title;
  String description;
  String taskHour;
  String taskDay;

  TaskDTO({
    required this.title,
    required this.description,
    required this.taskHour,
    required this.taskDay,
  });

 

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'taskHour': taskHour,
    'taskDay': taskDay
  };
}

