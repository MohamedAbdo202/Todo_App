import 'package:intl/intl.dart';

import 'Sqflite.dart';

class MyRepository {
  final SqfliteDataSource dataSource;

  MyRepository(this.dataSource);

  Future<void> createDatabase() async {
    await dataSource.createDatabase();
  }

  Future<List<Map>> getAllRooms() async {
    // Make sure the database is created before accessing it.
    await dataSource.createDatabase();
    return await dataSource.GetDatabase(dataSource.database);
  }

  Future<void> insertBooking( {
    required String title,
    required String date,
    required String time,
  }) async {
    // Make sure the database is created before inserting the booking.
    await dataSource.createDatabase();
    await dataSource.insertBooking(title:title,date: date,time:time );
  }


  Future<void> update( {required String status,required int id}) async {
    // Make sure the database is created before inserting the booking.
    await dataSource.createDatabase();
    await dataSource.databaseupdate(status: 'status',id:id );
  }

  Future<void> deleteBooking(int id) async {
    // Make sure the database is created before deleting the booking.
    await dataSource.createDatabase();
    await dataSource.deletedatabase(id);
  }


}

