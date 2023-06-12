

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/domain/entities/todo.dart';

class SharedPreferenceHelper {
  static const String _todoKey = 'todos';

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    // Here we're serializing our list of todos into a JSON string and storing it
    final todosJsonString = jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(_todoKey, todosJsonString);
  }

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJsonString = prefs.getString(_todoKey);
    if (todosJsonString != null) {
      final todosJsonList = jsonDecode(todosJsonString) as List;
      return todosJsonList.map((todoJson) => Todo.fromJson(todoJson)).toList();
    } else {
      return [];
    }
  }
}
