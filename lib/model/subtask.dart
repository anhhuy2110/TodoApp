
class SubTask {
  int? id;
  String title;
  bool status = false;

  SubTask({
    this.id,
    required this.title,
    this.status = false,
  });

  SubTask.fromMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.title = map['title'],
        this.status = map['status'];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'status': this.status,
    };
  }
}



