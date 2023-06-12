import 'package:todo_app/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<void> addTodo(Todo todo);
  Future<List<Todo>> getTodos();
  Future<void> markTodoAsCompleted(int id);
  Future<void> removeTodo(int id);
  // And similarly for other use cases
}

class TodoRepositoryImpl implements TodoRepository {
  final List<Todo> todos = [];

  @override
  Future<void> addTodo(Todo todo) async {
    todos.add(todo);
  }

  @override
  Future<List<Todo>> getTodos() async {
    return todos;
  }

  @override
  Future<void> markTodoAsCompleted(int id) async {
    final todo = todos.firstWhere((element) => element.id == id);
    todo.isCompleted = true;
  }

  @override
  Future<void> removeTodo(int id) async {
    todos.removeWhere((element) => element.id == id);
  }
  
}