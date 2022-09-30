import 'package:todolist_provider/app/models/task_model.dart';
import 'package:todolist_provider/app/models/week_task_model.dart';
import 'package:todolist_provider/app/repository/tasks/tasks_repositorys.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepositorys _tasksRepositorys;

  TasksServiceImpl({required TasksRepositorys tasksRepositorys})
      : _tasksRepositorys = tasksRepositorys;
  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepositorys.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _tasksRepositorys.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    final tomorrowDate = DateTime.now().add(const Duration(days: 2));
    return _tasksRepositorys.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _tasksRepositorys.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(
        startDate: startFilter, endDate: endFilter, tasks: tasks);
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) =>
      _tasksRepositorys.checkOrUncheckTask(task);
}
