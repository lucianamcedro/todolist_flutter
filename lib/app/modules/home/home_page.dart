// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todolist_provider/app/core/notifier/default_listener_notifier.dart';

import 'package:todolist_provider/app/core/ui/theme/theme_extension.dart';
import 'package:todolist_provider/app/models/task_filter_enum.dart';
import 'package:todolist_provider/app/modules/home/home_controller.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_header.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {
  final HomeController _homecontroller;
  const HomePage({
    Key? key,
    required HomeController homecontroller,
  })  : _homecontroller = homecontroller,
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._homecontroller).listener(
        context: context,
        sucessVoidCallback: ((notifier, listenerNotifier) {
          listenerNotifier.dispose();
        }));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._homecontroller.loadTotalTasks();
      widget._homecontroller.findTasks(filter: TaskFilterEnum.today);
    });
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    // Navigator.of(context).pushNamed('/task/create');
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 400,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInQuad,
          );
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TasksModule().getPage('/task/create', context);
        },
      ),
    );
    widget._homecontroller.refleshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        iconTheme: IconThemeData(color: context.primaryColor),
        actions: [
          PopupMenuButton(
            onSelected: (value) =>
                widget._homecontroller.showOrHideFinishingTask(),
            icon: const Icon(
              Icons.filter_alt,
              size: 32,
            ),
            itemBuilder: (context) => [
              PopupMenuItem<bool>(
                value: true,
                child: Text(
                  '${widget._homecontroller.showFinishingTasks ? 'Esconder' : 'Mostrar'} tarefas concluídas',
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _goToCreateTask(context),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
