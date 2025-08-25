import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [];

  void _addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void _editTask(Task editedTask) {
    setState(() {
      final index = tasks.indexWhere((t) => t.id == editedTask.id);
      if (index != -1) tasks[index] = editedTask;
    });
  }

  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((t) => t.id == id);
    });
  }

  void _toggleDone(String id) {
    setState(() {
      final index = tasks.indexWhere((t) => t.id == id);
      if (index != -1) tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void _goToAddTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(onAddTask: _addTask),
      ),
    );
  }

  void _goToEditTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTaskScreen(task: task, onEditTask: _editTask),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Home'),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks. Add some!'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskCard(
                  task: task,
                  onDelete: () => _deleteTask(task.id),
                  onToggleDone: () => _toggleDone(task.id),
                  onEdit: () => _goToEditTask(task),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
