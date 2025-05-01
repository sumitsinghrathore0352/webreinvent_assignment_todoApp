import 'package:assignment_todo_app/model/task_model.dart';
import 'package:assignment_todo_app/services/task_services.dart';
import 'package:flutter/foundation.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  final TaskService _service = TaskService();

  List<Task> get tasks => _tasks;

  TaskViewModel() {
    loadTasks();
  }

  void addTask(String title) {
    _tasks.add(Task(title: title));
    saveTasks();
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    saveTasks();
    notifyListeners();
  }

  void saveTasks() {
    _service.saveTasks(_tasks);
  }

  void loadTasks() async {
    _tasks = await _service.loadTasks();
    notifyListeners();
  }
  void deleteAllTasks() {
  _tasks.clear();
  saveTasks();
  notifyListeners();
}

}
