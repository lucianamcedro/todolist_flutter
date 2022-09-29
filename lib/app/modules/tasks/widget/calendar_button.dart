// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/app/core/ui/theme/theme_extension.dart';
import 'package:todolist_provider/app/modules/tasks/tasks_crete_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');
  CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 10 * 365));
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );
        context.read<TasksCreteController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Selector<TasksCreteController, DateTime?>(
                selector: (context, controller) => controller.selectedDate,
                builder: (context, selectedDate, child) {
                  if (selectedDate != null) {
                    return Text(
                      dateFormat.format(selectedDate),
                      style: context.titleStyle,
                    );
                  } else {
                    return const Text('SELECIONE UMA DATA');
                  }
                })
          ],
        ),
      ),
    );
  }
}
