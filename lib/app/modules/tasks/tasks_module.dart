import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_crete_controller.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(bindings: [
          ChangeNotifierProvider(
            create: (context) => TasksCreteController(),
          ),
        ], routers: {
          '/task/create': (context) => TasksCreatePage(
                controller: context.read(),
              )
        });
}
