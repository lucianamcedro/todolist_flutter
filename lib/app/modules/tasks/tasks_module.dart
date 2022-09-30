import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_crete_controller.dart';
import 'package:todolist_provider/app/repository/tasks/tasks_repositorys.dart';
import 'package:todolist_provider/app/repository/tasks/tasks_repositorys_impl.dart';
import 'package:todolist_provider/app/service/tasks/tasks_service.dart';
import 'package:todolist_provider/app/service/tasks/tasks_service_impl.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(bindings: [
          Provider<TasksRepositorys>(
            create: (context) => TasksRepositorysImpl(
              sqliteConnectionFactory: context.read(),
            ),
          ),
          Provider<TasksService>(
            create: (context) => TasksServiceImpl(
              tasksRepositorys: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                TasksCreteController(tasksService: context.read()),
          ),
        ], routers: {
          '/task/create': (context) => TasksCreatePage(
                controller: context.read(),
              )
        });
}
