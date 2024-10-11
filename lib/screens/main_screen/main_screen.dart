import 'package:flutter/material.dart';
import 'package:todolistapp/api/todo_list_api.dart';
import 'package:todolistapp/models/task_model.dart';
import 'package:todolistapp/screens/view_task/view_task.dart';
import 'package:todolistapp/utils/app_color.dart';
import 'package:todolistapp/utils/app_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  int _selectedPriority = 3;
  void _deleteTask({required int taskId}) async {
    bool deleteSuccessfully = await TodoListApi.deleteTask(taskId: taskId);
    if (deleteSuccessfully) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(PopUpMessage.taskDeletedSuccessful),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(PopUpMessage.error),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List<Task> _sortTasksByPriority(List<Task> tasks, int targetPriority) {
    tasks.sort((a, b) {
      if (a.priority == null && b.priority == null) return 0;
      if (a.priority == null) return 1;
      if (b.priority == null) return -1;
      final aIsTarget = a.priority == targetPriority;
      final bIsTarget = b.priority == targetPriority;

      if (aIsTarget && !bIsTarget) {
        return -1;
      } else if (!aIsTarget && bIsTarget) {
        return 1;
      } else {
        return b.priority!.compareTo(a.priority!);
      }
    });

    return tasks;
  }

  Future<void> _taskDone(bool value, {required String taskId}) async {
    if (value) {
      await TodoListApi.closeTask(taskId: taskId);
    } else {
      await TodoListApi.reopenTask(taskId: taskId);
    }
  }

  Color _titleColor(int priority) {
    switch (priority) {
      case 1:
        return TaskPriorityColor.high;
      case 2:
        return TaskPriorityColor.medium;
      case 3:
        return TaskPriorityColor.low;
      default:
        return TaskPriorityColor.low;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onTapOutside: (event) {
                        _searchFocusNode.unfocus();
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        hintText: MainScreenText.search,
                        hintStyle: TextStyle(color: AppColors.quaternary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select priority'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                            value: 1,
                                            groupValue: _selectedPriority,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedPriority = value!;
                                                Navigator.pop(context);
                                              });
                                            }),
                                        const Text(AppText.priority1,
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                            value: 2,
                                            groupValue: _selectedPriority,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedPriority = value!;
                                                Navigator.pop(context);
                                              });
                                            }),
                                        const Text(AppText.priority2,
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                            value: 3,
                                            groupValue: _selectedPriority,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedPriority = value!;
                                                Navigator.pop(context);
                                              });
                                            }),
                                        const Text(AppText.priority3,
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Icon(Icons.filter_list))
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                    future: TodoListApi.getAllTask(),
                    builder: (context, AsyncSnapshot<List<Task>> snapshot) {
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
                                  setState(() {});
                                },
                                icon: const Icon(Icons.refresh),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final List<Task> data =
                            _sortTasksByPriority(snapshot.data!, _selectedPriority);
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _titleColor(data[index].priority!),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewTask(
                                              taskId: data[index].id!,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ListTileStyle.list,
                                      leading: Checkbox(
                                          value: data[index].isCompleted,
                                          onChanged: (value) {
                                            setState(() {
                                              _taskDone(value!, taskId: data[index].id!);
                                            });
                                          }),
                                      title: Text(
                                        data[index].content ?? 'noTitle',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 20,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _deleteTask(taskId: int.parse(data[index].id!));
                                          });
                                        },
                                        icon: const Icon(Icons.delete,
                                            size: 25, color: AppColors.primary),
                                      )),
                                ),
                              );
                            });
                      } else {
                        return const Placeholder();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/AddTaskScreen');
        },
        child: const Icon(Icons.add_box),
      ),
    );
  }
}
