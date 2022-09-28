import 'package:flutter/material.dart';
import 'package:todolist_provider/app/core/ui/theme/theme_extension.dart';
import 'package:todolist_provider/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'TASK\'S DE HOJE',
            style: context.titleStyle,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Task(),
            ],
          )
        ],
      ),
    );
  }
}
