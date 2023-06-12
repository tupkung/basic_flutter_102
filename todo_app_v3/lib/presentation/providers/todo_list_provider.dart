import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/domain/use_cases/get_todos_use_case.dart';
import 'package:todo_app/domain/use_cases/mark_todo_as_completed_use_case.dart';
import 'package:todo_app/domain/use_cases/remove_todo_use_case.dart';

class TodoListProvider {
  final GetTodosUseCase getTodosUseCase;
  final RemoveTodoUseCase removeTodoUseCase;
  final MarkTodoAsCompletedUseCase markTodoAsCompletedUseCase;

  TodoListProvider({
    required this.getTodosUseCase,
    required this.removeTodoUseCase,
    required this.markTodoAsCompletedUseCase,
  });

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> getTodos() async {
    _todos = await getTodosUseCase.call();
  }

  Future<void> removeTodoById(int id) async {
    await removeTodoUseCase.call(id);
    _todos.removeWhere((element) => element.id == id);
  }

  Future<void> markTodoAsCompletedById(int id) async {
    await markTodoAsCompletedUseCase.call(id);
    _todos.firstWhere((element) => element.id == id).isCompleted = true;
  }
}
