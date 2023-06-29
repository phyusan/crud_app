import 'dart:convert';

import 'package:crud_app/Domain/task_model.dart';
import 'package:crud_app/constapi/api_constant.dart';

import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class ApiService {
  Future<List<Task>> getTask() async {
    List<Task> todolist = [];
    var response = await http.get(Uri.parse(endpoint));
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        todolist.add(Task.fromJson(data[i]));
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
    return todolist;
  }

  Future<String> deleteTask(Task tk) async {
    var result = 'false';
    var response = await http
        .delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    )
        .then((value) {
      return result = 'true';
    });
    return result;
  }

  Future<String> editTask(Task tk) async {
    var res = '';
    var response = await http
        .put(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'), body: {
      'title': (tk.title!).toString(),
    }).then((value) {
      Map<String, dynamic> putdata = json.decode(value.body);
      return res = putdata['title'];
    });
    return res;
  }

  Future<String> addTask(Task tk) async {
    var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: tk.toJson());
    print(response.statusCode);
    print(tk.toJson());
    if (response.statusCode == 201) {
      return 'true';
    }

    return 'true';
  }
}

final getTaskProvider = Provider<ApiService>((ref) => ApiService());
