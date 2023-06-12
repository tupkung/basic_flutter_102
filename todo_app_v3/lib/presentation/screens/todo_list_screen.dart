import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/domain/use_cases/get_todos_use_case.dart';
import 'package:todo_app/domain/use_cases/mark_todo_as_completed_use_case.dart';
import 'package:todo_app/domain/use_cases/remove_todo_use_case.dart';

class TodoListScreen extends StatelessWidget {
  final GetTodosUseCase getTodosUseCase;
  final RemoveTodoUseCase removeTodoUseCase;
  final MarkTodoAsCompletedUseCase markTodoAsCompletedUseCase;
  final Function(int id)? onRemoveTodo;
  final Function(int id)? onMarkTodoAsCompleted;
  final Function()? onAddTodo;

  const TodoListScreen({super.key, required this.getTodosUseCase, required this.removeTodoUseCase, required this.markTodoAsCompletedUseCase, required this.onRemoveTodo, required this.onAddTodo, required this.onMarkTodoAsCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: FutureBuilder(
        future: _buildBody(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onAddTodo?.call();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Widget> _buildBody() async {
    var todos = await getTodosUseCase.call();
    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos'),
      );
    } else {
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          var todo = todos[index];
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    await markTodoAsCompletedUseCase.call(todo.id);
                    onMarkTodoAsCompleted?.call(todo.id);
                  },
                  label: 'Complete',
                  backgroundColor: Colors.green.shade400,
                  icon: Icons.archive,
                ),
                SlidableAction(
                  onPressed: (context) async {
                    await removeTodoUseCase.call(todo.id);
                    onRemoveTodo?.call(todo.id);
                  },
                  label: 'Delete',
                  backgroundColor: Colors.red.shade400,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: ListTile(
              title: Text(todo.title),
              trailing: todo.isCompleted ? const Icon(Icons.check) : null,
              onTap: ()  {
                // do nothing
              },
            )
          );
        },
      );
    }
  }
}
