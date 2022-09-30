import 'package:todolist_provider/app/models/task_model.dart';

abstract class TasksRepositorys {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
  Future<void> checkOrUncheckTask(TaskModel task);
}
