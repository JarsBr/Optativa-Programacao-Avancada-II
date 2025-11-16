class Task {
  int? id;        // Usado apenas no SQLite
  String title;
  bool done;

  Task({
    this.id,
    required this.title,
    required this.done,
  });

  // JSON → Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      done: json["done"] ?? false,
    );
  }

  // Task → JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "done": done,
    };
  }

  Task copyWith({int? id, String? title, bool? done}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }
}
