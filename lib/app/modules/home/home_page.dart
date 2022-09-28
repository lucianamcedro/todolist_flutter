import 'package:flutter/material.dart';

import 'package:todolist_provider/app/core/ui/theme/theme_extension.dart';

import 'package:todolist_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_header.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todolist_provider/app/modules/home/widgets/home_week_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        iconTheme: IconThemeData(color: context.primaryColor),
        actions: [
          PopupMenuButton(
            // onSelected: (value) => widget._controller.showOrHideFinishedTasks(),
            icon: const Icon(
              Icons.filter_alt,
              size: 32,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem<bool>(
                value: true,
                child: Text('Mostrar tarefas'
                    // '${widget._controller.showFinishedTasks ? 'Esconder' : 'Mostrar'} tarefas concluídas',
                    ),
              ),
            ],
          ),
        ],
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
