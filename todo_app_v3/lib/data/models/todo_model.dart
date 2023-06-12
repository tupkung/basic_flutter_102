import 'package:todo_app/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({required id, required title, required description, required isCompleted})
      : super(id: id, title: title, description: description, isCompleted: isCompleted);
  
  // Add methods for serializing and deserializing the model
  
}