import 'package:todolist_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todolist_provider/app/models/task_filter_enum.dart';
import 'package:todolist_provider/app/models/task_model.dart';
import 'package:todolist_provider/app/models/total_tasks_model.dart';
import 'package:todolist_provider/app/models/week_task_model.dart';
import 'package:todolist_provider/app/service/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  TaskFilterEnum filterSelected = TaskFilterEnum.tomorrow;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateWeek;
  DateTime? selectedDay;
  bool showFinishingTasks = false;
  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
        totalTasks: todayTasks.length,
        totalTasksFinish: todayTasks.where((task) => task.finished).length);
    tomorrowTotalTasks = TotalTasksModel(
        totalTasks: tomorrowTasks.length,
        totalTasksFinish: tomorrowTasks.where((task) => task.finished).length);
    weekTotalTasks = TotalTasksModel(
        totalTasks: weekTasks.tasks.length,
        totalTasksFinish:
            weekTasks.tasks.where((task) => task.finished).length);

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;
    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        initialDateWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;
    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByDay(selectedDay!);
      } else if (initialDateWeek != null) {
        filterByDay(initialDateWeek!);
      } else {
        selectedDay = null;
      }
    }

    if (!showFinishingTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) {
      return task.dateTime == selectedDay;
    }).toList();
    notifyListeners();
  }

  Future<void> refleshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUcheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();
    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refleshPage();
  }

  void showOrHideFinishingTask() {
    showFinishingTasks = !showFinishingTasks;
    refleshPage();
  }
}
