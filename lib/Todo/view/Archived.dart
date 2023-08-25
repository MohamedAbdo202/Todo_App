import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ViewModel/CubitTodo.dart';
import '../ViewModel/StatsTodo.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomCubit, MyState>(
      listener: (context, state) {},
      builder: (context, state) {
        var _cubit = BlocProvider.of<RoomCubit>(context);
        List<Map> tasks = _cubit.archivedtasks; // Get the new tasks from the cubit

        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]['title'] ?? ''),
                subtitle: Text(tasks[index]['date'] ?? ''),
              );
            },
            separatorBuilder: (context, index) => Divider(
              height: 3.h,
              color: Colors.black,
            ),
            itemCount: tasks.length,
          ),
        );
      },
    );
  }
}
