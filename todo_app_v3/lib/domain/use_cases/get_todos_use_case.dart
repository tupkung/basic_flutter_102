import 'package:todo_app/domain/entities/todo.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository _todoRepository;

  GetTodosUseCase(this._todoRepository);

  Future<List<Todo>> call() async {
    return await _todoRepository.getTodos();
  }
}