import "dart:convert";
import "package:http/http.dart" as http;
import "package:todolistapp/api/api_keys.dart";
import "package:todolistapp/models/project_model.dart";
import "package:todolistapp/models/task_model.dart";

class TodoListApi {
  static Future<Project> getProjects() async {
    const String url = "https://api.todoist.com/rest/v2/projects";
    final apiResponse = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $todoListApiKey'},
    );

    if (apiResponse.statusCode == 200) {
      return Project.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception("Response wasn't 200: ${apiResponse.statusCode}");
    }
  }

  static Future<bool> addTask({required Task createdTask}) async {
    const String url = "https://api.todoist.com/rest/v2/tasks";
    final apiResponse = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $todoListApiKey', "Content-Type": "application/json"},
      body: jsonEncode(createdTask.toJson()),
    );
    if (apiResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Task>> getAllTask() async {
    const String url = "https://api.todoist.com/rest/v2/tasks";
    final apiResponse = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $todoListApiKey'},
    );

    if (apiResponse.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(apiResponse.body);
      return List.generate(jsonData.length, (index) => Task.fromJson(jsonData[index]));
    } else {
      throw Exception("Response wasn't 200: ${apiResponse.statusCode}");
    }
  }

  static Future<Task> getTask({required String taskId}) async {
    final String url = 'https://api.todoist.com/rest/v2/tasks/$taskId';
    final apiResponse = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $todoListApiKey'},
    );
    if (apiResponse.statusCode == 200) {
      return Task.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('The response wasn\'t 200 : ${apiResponse.statusCode}');
    }
  }

  static Future<bool> deleteTask({required int taskId}) async {
    final String url = "https://api.todoist.com/rest/v2/tasks/$taskId";
    final apiResponse = await http.delete(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $todoListApiKey'},
    );
    if (apiResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> updateTask({required taskId, required String task}) async {
    final String url = "https://api.todoist.com/rest/v2/tasks/$taskId";
    final apiResponse = await http.put(Uri.parse(url), headers: {
      'Authorization': 'Bearer $todoListApiKey',
      "Content-Type": "application/json",
    }, body: {
      'content': task,
    });
  }

  static Future<bool> closeTask({required String taskId}) async {
    final String url = 'https://api.todoist.com/rest/v2/tasks/$taskId/close';
    final apiResponse = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $todoListApiKey'},
    );
    if (apiResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> reopenTask({required String taskId}) async {
    final String url = 'https://api.todoist.com/rest/v2/tasks/$taskId/reopen';
    final apiResponse = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $todoListApiKey'},
    );
    if (apiResponse.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
