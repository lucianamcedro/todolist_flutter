// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todolist_provider/app/models/task_model.dart';

class WeekTaskModel {
  final DateTime startDate;
  final DateTime endDate;
  List<TaskModel> tasks;
  WeekTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}
