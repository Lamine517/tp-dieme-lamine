import 'package:todoapp/models/category.dart';

class Task {
  final String title;
  final DateTime? dueTime;
  final bool isDone;
  final String category;
  
  Task({
    required this.title, 
    required this.dueTime, 
    required this.isDone, 
    required this.category
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      dueTime: DateTime.tryParse(json['dueTime']),
      isDone: json['done'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() =>
  {
    'title': title,
    'dueTime': dueTime,
    'done': isDone,
    'category': category,
  };
}