import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/modules/todo_list_module.dart';
import 'package:todolist_provider/app/modules/home/home_controller.dart';

import 'package:todolist_provider/app/modules/home/home_page.dart';
import 'package:todolist_provider/app/repository/tasks/tasks_repositorys.dart';
import 'package:todolist_provider/app/repository/tasks/tasks_repositorys_impl.dart';
import 'package:todolist_provider/app/service/tasks/tasks_service.dart';
import 'package:todolist_provider/app/service/tasks/tasks_service_impl.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          bindings: [
            Provider<TasksRepositorys>(
                create: (context) => TasksRepositorysImpl(
                    sqliteConnectionFactory: context.read())),
            Provider<TasksService>(
                create: (context) =>
                    TasksServiceImpl(tasksRepositorys: context.read())),
            ChangeNotifierProvider(
              create: (context) => HomeController(tasksService: context.read()),
            ),
          ],
          routers: {
            '/home': (context) => HomePage(homecontroller: context.read()),
          },
        );
}
