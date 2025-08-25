import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/app_button.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onEditTask;

  const EditTaskScreen({super.key, required this.task, required this.onEditTask});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descController = TextEditingController(text: widget.task.description);
  }

  void _saveChanges() {
    final newTitle = titleController.text.trim();
    final newDesc = descController.text.trim();

    if (newTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task title cannot be empty')));
      return;
    }

    final updatedTask = Task(
      id: widget.task.id,
      title: newTitle,
      description: newDesc,
      isDone: widget.task.isDone,
    );

    widget.onEditTask(updatedTask);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            AppButton(text: 'Save Changes', onPressed: _saveChanges),
          ],
        ),
      ),
    );
  }
}
