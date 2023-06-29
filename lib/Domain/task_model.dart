class Task {
  int? userId;
  int? id;
  String? title;
  String? body;

  Task({this.userId, this.id, this.title, this.body});

  Task.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId.toString();
    data['id'] = id.toString();
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
