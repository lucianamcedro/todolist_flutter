import 'package:todolist_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todolist_provider/app/service/tasks/tasks_service.dart';

class TasksCreteController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TasksCreteController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  void save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        sucess();
      } else {
        setError('Data de task não selecionada');
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
