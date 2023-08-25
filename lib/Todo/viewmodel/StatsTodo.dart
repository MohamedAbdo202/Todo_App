abstract class MyState {}

class InitialState extends MyState {}

class DatabaseCreatedState extends MyState {}

class DatabaseInsertedState extends MyState {}
class DatabaseDeletedState extends MyState {}

class AppChangeBottomNavBarState extends MyState {}

class RoomsLoadedState extends MyState {

  RoomsLoadedState();
}

class ChangeBottomSheet extends MyState{}

class DatabaseErrorState extends MyState {
  final String errorMessage;

  DatabaseErrorState(this.errorMessage);
}
class DatabaseGetErrorState extends MyState {
  final String errorMessage;

  DatabaseGetErrorState(this.errorMessage);
}

class DeletedErrorState extends MyState {
  final String errorMessage;

  DeletedErrorState(this.errorMessage);
}

class InsertErrorState extends MyState {
  final String errorMessage;

  InsertErrorState(this.errorMessage);
}