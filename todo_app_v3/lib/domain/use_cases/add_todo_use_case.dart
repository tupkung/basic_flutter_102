import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository _todoRepository;

  AddTodoUseCase(this._todoRepository);

  Future<void> call(Todo todo) async {
    return await _todoRepository.addTodo(
      todo
    );
  }
}