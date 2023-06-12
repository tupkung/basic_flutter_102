


import 'package:flutter/material.dart';
import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/domain/use_cases/add_todo_use_case.dart';

class TodoAddScreen extends StatefulWidget {
  final AddTodoUseCase addTodoUseCase;
  final Function()? onAddTodo;

  const TodoAddScreen({Key? key, required this.addTodoUseCase, this.onAddTodo}) : super(key: key);

  @override
  _TodoAddScreenState createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    await widget.addTodoUseCase.call(
                      Todo(
                        id: DateTime.now().millisecondsSinceEpoch,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isCompleted: false,
                      )
                    );
                    widget.onAddTodo?.call();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

