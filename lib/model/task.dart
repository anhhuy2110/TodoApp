

import 'package:interview/model/subtask.dart';

class Task {
  int? id;
  String title;
  String description;
  String dateTask;
  bool status = false;
  List<SubTask> subtasks;


  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dateTask,
    this.status = false,
    this.subtasks = const []
  });

  Task.fromMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.title = map['title'],
        this.description = map['description'],
        this.dateTask = map['dateTask'],
        this.status = map['status'],
        this.subtasks = List<SubTask>.from(map['subtasks'].map((x) => SubTask.fromMap(x)));

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'dateTask': this.dateTask,
      'status': this.status,
      'subtasks': List<dynamic>.from(subtasks.map((x) => x.toMap())),
    };
  }
  void addSubTask(SubTask subTask) {
    subtasks.add(subTask);
  }
}





//
// class Task {
//   int? id;
//   String title;
//   String description;
//   String dateTask;
//   bool status = false;
//
//   Task({
//     this.id,
//     required this.title,
//     required this.description,
//     required this.dateTask,
//     this.status = false,
//   });
//
//   Task.fromMap(Map<String, dynamic> map)
//       : this.id = map['id'],
//         this.title = map['title'],
//         this.description = map['description'],
//         this.dateTask = map['dateTask'],
//         this.status = map['status'];
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': this.id,
//       'title': this.title,
//       'description': this.description,
//       'dateTask': this.dateTask,
//       'status': this.status,
//     };
//   }
// }
//
