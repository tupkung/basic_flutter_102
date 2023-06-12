import 'package:todo_app/data/repositories/todo_repository.dart';


class MarkTodoAsCompletedUseCase {
  final TodoRepository _todoRepository;

  MarkTodoAsCompletedUseCase(this._todoRepository);

  Future<void> call(int todoId) async {
    return await _todoRepository.markTodoAsCompleted(
      todoId
    );
  }
}