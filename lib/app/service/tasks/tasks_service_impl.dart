import 'package:todolist_provider/app/repository/tasks/tasks_repositorys.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepositorys _tasksRepositorys;

  TasksServiceImpl({required TasksRepositorys tasksRepositorys})
      : _tasksRepositorys = tasksRepositorys;
  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepositorys.save(date, description);
}
