import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class SqfliteDataSource {
  Database? database;
  List<Map>Rooms=[];


  void _initSqflite() {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  }

  Future<void> createDatabase() async {

    database = await openDatabase(
      'Hotel.db',
      version: 1,
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY NOT NULL,title TEXT NOT NULL,date TEXT NOT NULL,time TEXT NOT NULL,status TEXT NOT NULL)',
        );
        print('Table Created');
      },

      onOpen: (database) async {

        await GetDatabase(database).then((value) {

          Rooms=value;


        });        print('database open ');


      },

    );
  }


  Future<List<Map>> GetDatabase(database) async{
    return await database!.rawQuery('SELECT* FROM notes');


  }


  Future<void> databaseupdate ({required String status,required int id}) async {
     await database?.rawUpdate(
        'UPDATE notes SET status = ? WHERE id = ?',
        ['${status}',id]
    ).then((value)
    {
      GetDatabase(database!);
    }).catchError((e)=>print(e.toString()));
  }




  Future<void> deletedatabase(int requiredid) async {
    // Replace 'sql' with the actual SQL query you want to execute.
    String sql = 'DELETE FROM ROOMS WHERE id = ?';

    // Perform the raw SQL delete operation asynchronously using 'rawDelete'.
    await database!.rawDelete(sql, [requiredid]);
    await GetDatabase(database).then((value) {

      Rooms=value;
    });
  }


  Future<void> insertBooking({
    required String title,
    required String date,
    required String time,
  } ) async {
    final db = await database; // Make sure the database is initialized before calling this function

    try {
      await db!.transaction((txn) async {
        txn.rawInsert('INSERT INTO notes(title,date,time,status) VALUES ("${title}","${date}","${time}","new")');


      });
      await GetDatabase(database).then((value) {

        Rooms=value;
        print(Rooms);
      });
      print('Booking inserted successfully');
    } catch (error) {
      print('Error in insert: ${error.toString()}');
    }
  }
}
