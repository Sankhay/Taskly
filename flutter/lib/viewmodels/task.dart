import 'package:taskly/services/task.dart';
import 'dart:convert';
import 'package:taskly/models/task.dart';

class TaskViewModel  {

  final TaskService _taskService = TaskService();

  Future<(bool, List<Task>?)> getTasks() async {

    final response = await _taskService.getTasks();

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      final List<Task> taskList = jsonList.map((json) => Task.fromJson(json)).toList();

      return (true, taskList);
    } else {
      return (false, null);
    }
  }

  Future<(bool, Task?)> getTask(String taskId) async {

    final response = await _taskService.getTask(taskId);

    if (response.statusCode == 200) {
      final Task task  = jsonDecode(response.body);

      return (true, task);
    } else {
      return (false, null);
    }
  }

  Future<bool> createTask(String title, String description, String taskHour, String taskDay) async {
      
      final TaskDTO newTask = TaskDTO(title: title, description: description, taskHour: taskHour, taskDay: taskDay);

      final response = await _taskService.createTask(newTask);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
  }

  Future<bool> updateTask(String id, String title, String description, String taskHour, String taskDay) async {
      
      final TaskDTO updatedTask = TaskDTO(title: title, description: description, taskHour: taskHour, taskDay: taskDay);

      final response = await _taskService.updateTask(id, updatedTask);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
  }

  Future<bool> deleteTask(String id) async {
    final response = await _taskService.deleteTask(id);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

  }
}