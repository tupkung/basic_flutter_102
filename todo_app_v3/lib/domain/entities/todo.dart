
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String title;
  final String description;
  bool isCompleted;

  Todo({required this.id, required this.title, required this.description, this.isCompleted = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed']
    );
  }

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
