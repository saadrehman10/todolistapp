import 'package:flutter/material.dart';
import 'package:todolistapp/api/todo_list_api.dart';
import 'package:todolistapp/models/task_model.dart';
import 'package:todolistapp/utils/app_color.dart';
import 'package:todolistapp/utils/app_text.dart';

class ViewTask extends StatelessWidget {
  final String taskId;
  const ViewTask({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: TodoListApi.getTask(taskId: taskId),
          builder: (context, AsyncSnapshot<Task> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(MainScreenText.waitingText),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      snapshot.error.toString(),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewTask(
                              taskId: taskId,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.content!,
                        style: const TextStyle(
                          color: AppColors.tertiary,
                          fontSize: 60,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        ViewTaskScreen.description,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        snapshot.data!.description!,
                        style: const TextStyle(
                          color: AppColors.tertiary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Placeholder();
            }
          }),
    );
  }
}
