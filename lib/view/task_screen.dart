import 'package:assignment_todo_app/viewModel/task_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskVM = Provider.of<TaskViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter new task',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      taskVM.addTask(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskVM.tasks.length,
              itemBuilder: (context, index) {
                final task = taskVM.tasks[index];
                return CheckboxListTile(
                  value: task.isDone,
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                  ),
                  onChanged: (_) => taskVM.toggleTask(index),
                );
              },
            ),
          ),
          // Inside the `Column` in the build method, after Expanded(child: ListView...):
          ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Delete All Tasks'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text(
                        'Are you sure you want to delete all tasks?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            taskVM.deleteAllTasks();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
              );
            },
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height / 20),
        ],
      ),
    );
  }
}
