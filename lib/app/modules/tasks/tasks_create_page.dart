import 'package:flutter/material.dart';
import 'package:todolist_provider/app/core/ui/theme/theme_extension.dart';
import 'package:todolist_provider/app/core/widget/todo_list_field.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_crete_controller.dart';
import 'package:todolist_provider/app/modules/tasks/widget/calendar_button.dart';

class TasksCreatePage extends StatelessWidget {
  TasksCreteController _controller;
  TasksCreatePage({Key? key, required TasksCreteController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: context.primaryColor,
            onPressed: () {},
            label: const Text(
              'Salvar Task',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        body: Form(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Criar Tarefa",
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TodoListField(label: ''),
              const SizedBox(
                height: 20,
              ),
              CalendarButton(),
            ],
          ),
        )));
  }
}
