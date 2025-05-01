import 'dart:convert';
import 'package:assignment_todo_app/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  static const String _key = 'tasks';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = tasks.map((t) => t.toJson()).toList();
    prefs.setString(_key, jsonEncode(jsonData));
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data != null) {
      final List decoded = jsonDecode(data);
      return decoded.map((e) => Task.fromJson(e)).toList();
    }
    return [];
  }
}
