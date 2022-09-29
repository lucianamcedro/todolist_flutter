import 'package:todolist_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todolist_provider/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {
  final TaskFilterEnum filterSelected = TaskFilterEnum.tomorrow;
}
