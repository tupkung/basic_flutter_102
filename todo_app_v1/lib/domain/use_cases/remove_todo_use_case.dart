import 'package:todo_app/data/repositories/todo_repository.dart';

class RemoveTodoUseCase {
  final TodoRepository _todoRepository;

  RemoveTodoUseCase(this._todoRepository);

  Future<void> call(int todoId) async {
    return await _todoRepository.removeTodo(
      todoId
    );
  }
}