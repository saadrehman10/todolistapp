import 'package:flutter/material.dart';
import 'package:todolistapp/api/todo_list_api.dart';
import 'package:todolistapp/models/task_model.dart';
import 'dart:ui' as ui;
import 'package:todolistapp/utils/app_color.dart';
import 'package:todolistapp/utils/app_text.dart';
import 'package:todolistapp/widgets/loaing_animaiton.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskContentController = TextEditingController();
  final FocusNode _taskContentFocus = FocusNode();
  final TextEditingController _taskDescriptionController = TextEditingController();
  final FocusNode _taskDescriptionFocus = FocusNode();

  int _selectedPriority = 1;
  void _addTaskFunction(
      {required String content, required String description, required int priority}) async {
    Loading.loadingTemplateOne(context);
    Task taskDetail = Task();
    taskDetail.content = content;
    taskDetail.description = description;
    taskDetail.priority = priority;
    bool success = await TodoListApi.addTask(createdTask: taskDetail);
    if (success) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(PopUpMessage.taskAddedSuccessful),
          backgroundColor: Colors.green,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            AddTaskScreenText.pageTitle,
            style: TextStyle(
              color: AppColors.tertiary,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Text(
                      AddTaskScreenText.textFelidTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _taskContentController,
                    focusNode: _taskContentFocus,
                    onTapOutside: (event) {
                      _taskContentFocus.unfocus();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.secondary),
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value == null) {
                        return AddTaskScreenText.textFelidTitleValidatorOne;
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Text(
                      AddTaskScreenText.textFelidDescription,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _taskDescriptionController,
                    focusNode: _taskDescriptionFocus,
                    maxLines: 5,
                    selectionHeightStyle: ui.BoxHeightStyle.max,
                    onTapOutside: (event) {
                      _taskDescriptionFocus.unfocus();
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.secondary),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Text(
                      AddTaskScreenText.textFelidTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Radio(
                              value: 1,
                              groupValue: _selectedPriority,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedPriority = value!;
                                });
                              }),
                          const Text(AppText.priority1, style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Radio(
                              value: 2,
                              groupValue: _selectedPriority,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedPriority = value!;
                                });
                              }),
                          const Text(AppText.priority2, style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Radio(
                              value: 3,
                              groupValue: _selectedPriority,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedPriority = value!;
                                });
                              }),
                          const Text(AppText.priority3, style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addTaskFunction(
                                content: _taskContentController.text,
                                description: _taskDescriptionController.text,
                                priority: _selectedPriority,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: AppColors.secondary),
                          child: const Text(ButtonText.addTask,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
