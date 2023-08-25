import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Data/Repoistory.dart';

import '../View/Archived.dart';
import '../View/Done.dart';
import '../View/Tasks.dart';
import 'StatsTodo.dart';

class RoomCubit extends Cubit<MyState> {
  final MyRepository repository;

  RoomCubit(this.repository) : super(InitialState());
  int currentIndex = 0;
  static RoomCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<BottomNavigationBarItem>bottomitems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.menu,),
        label: 'Tasks'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.check_circle_outline,),
        label: 'Done'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined,),
        label: 'Archived'
    ),


  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  Future<void> createDatabase() async {
    try {
      await repository.createDatabase();
      emit(DatabaseCreatedState());
      getAllRooms(); // Refresh the room list after successful insertion.

    } catch (error) {
      emit(DatabaseErrorState('Failed to create database: ${error.toString()}'));
    }
  }
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedtasks = [];
  List<Map> Tasks = [];

  Future<void> getAllRooms() async {
     try {  Tasks=[];
     newTasks = [];
     doneTasks = [];
     archivedtasks = [];
     Tasks=   await repository.getAllRooms();
     Tasks.forEach((element) {
       if(element['status'] == 'new')
       {
         newTasks.add(element);
       }
       else if(element['status'] == 'done')
       {
         doneTasks.add(element);
       }
       else
       {
         archivedtasks.add(element);
       }
     });
      emit(RoomsLoadedState());
    } catch (error) {
      emit(DatabaseGetErrorState('Failed to load rooms: ${error.toString()}'));
    }
  }

  Future<void> deletedatabase(int id ) async {
    try {
      await repository.deleteBooking(id);
      emit(DatabaseDeletedState());
      await getAllRooms(); // Refresh the room list after successful insertion.
    } catch (error) {
      emit(DeletedErrorState('Failed to insert booking: ${error.toString()}'));
    }
  }


  bool isBottomSheet=false;
  IconData fabIcon = Icons.edit;
  Future<void> insertBooking( {
    required String title,
    required String date,
    required String time,
  }) async {

    try {
      await repository.insertBooking(time:time,date:date,title:title);
      emit(DatabaseInsertedState());
      getAllRooms(); // Refresh the room list after successful insertion.


    } catch (error) {
      emit(InsertErrorState('Failed to insert booking: ${error.toString()}'));
    }




  }






  void changeBottomSheet({required bool isShow,required IconData icon}){
    isBottomSheet=isShow;
    fabIcon=icon;

    emit(ChangeBottomSheet());


  }








}
