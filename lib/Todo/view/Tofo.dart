import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutttter/Todo%20App/ViewModel/CubitTodo.dart';

import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../ViewModel/StatsTodo.dart';

class TodoHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomCubit, MyState>(
      listener: (context, state) {},
      builder: (context, state) {
        var _cubit = BlocProvider.of<RoomCubit>(context); // Get cubit instance using BlocProvider

        return Form(
          key: _formState,
          child: Scaffold(
            key: _scaffoldState,
            appBar: AppBar(
              title: Text(_cubit.titles[_cubit.currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _cubit.currentIndex, // Fixed the usage here
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                _cubit.changeIndex(index); // Fixed the usage here
              },
              items: _cubit.bottomitems,
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                if (_cubit.isBottomSheet == true) {
                  if (_formState.currentState!.validate()) {
                    _cubit.insertBooking(
                      title: titleController.text.toString(),
                      date: dateController.text.toString(),
                      time: TimeOfDay.now().format(context).toString(),
                    );
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                      titleController.text = dateController.text = "";
                    }
                    _cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  }
                } else {
                  _scaffoldState.currentState!.showBottomSheet(
                        (context) {
                      return Container(
                        color: Colors.white10,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: titleController,
                              validator: (val) {
                                if (titleController.text.isEmpty) {
                                  return "title must not be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                label: const Text("Task title"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            TextFormField(
                              keyboardType: TextInputType.datetime,
                              controller: dateController,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022, 8),
                                  lastDate: DateTime(2029, 8),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              validator: (val) {
                                if (dateController.text.isEmpty) {
                                  return "Date must not be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                label: const Text("Expected Date "),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).closed.then((value) {
                    _cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  });
                  _cubit.changeBottomSheet(isShow: true, icon: Icons.edit);
                }
              },
            ),
            body: _cubit.screens[_cubit.currentIndex],
          ),
        );
      },
    );
  }
}
