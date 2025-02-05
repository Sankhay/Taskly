import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/constants/constants.dart';
import 'package:taskly/models/task.dart';
import 'dart:convert';

class TaskService {
  Future getTasks() async {

    final prefs = await SharedPreferences.getInstance();
    final authorizationToken = prefs.getString("authorizationToken")!;

    return await http.get(
      Uri.parse("${Constants.apiUrl}/task"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationToken
      },  
    ).timeout(Constants.returnApiTimeoutDuration);
  }

  Future getTask(String taskId) async {

    final prefs = await SharedPreferences.getInstance();
    final authorizationToken = prefs.getString("authorizationToken")!;

    return await http.get(
      Uri.parse("${Constants.apiUrl}/task/$taskId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': authorizationToken
      },  
    ).timeout(Constants.returnApiTimeoutDuration);
  }

  Future createTask(TaskDTO task) async {
    final prefs = await SharedPreferences.getInstance();
    final authorizationToken = prefs.getString("authorizationToken")!;

    return await http.post(
        Uri.parse("${Constants.apiUrl}/task"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationToken
        },
        body: jsonEncode(task)
      ).timeout(Constants.returnApiTimeoutDuration);
  }

  Future updateTask(String id, TaskDTO task) async {
    final prefs = await SharedPreferences.getInstance();
    final authorizationToken = prefs.getString("authorizationToken")!;

    return await http.put(
        Uri.parse("${Constants.apiUrl}/task/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationToken
        },
        body: jsonEncode(task)
      ).timeout(Constants.returnApiTimeoutDuration);
  }

  Future deleteTask(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final authorizationToken = prefs.getString("authorizationToken")!;

    return await http.delete(
        Uri.parse("${Constants.apiUrl}/task/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authorizationToken
        },
      ).timeout(Constants.returnApiTimeoutDuration);
  }
}
