import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/utils/shared_preference_helper.dart';

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

class TodoLocalRepositoryImpl implements TodoRepository {
  List<Todo> _todos = [];
  final _sharedPreferencesHelper = SharedPreferenceHelper();

  @override
  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
    await _sharedPreferencesHelper.saveTodos(_todos);
  }

  @override
  Future<List<Todo>> getTodos() async {
    _todos = [];
    _todos.addAll(await _sharedPreferencesHelper.loadTodos());
    return _todos;
  }

  @override
  Future<void> markTodoAsCompleted(int id) async {
    final todo = _todos.firstWhere((element) => element.id == id);
    final indexOfTodo = _todos.indexOf(todo);
    _todos[indexOfTodo] = Todo(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: true,
    );
    await _sharedPreferencesHelper.saveTodos(_todos);
  }

  @override
  Future<void> removeTodo(int id) async {
    _todos.removeWhere((element) => element.id == id);
    await _sharedPreferencesHelper.saveTodos(_todos);
  }
}
