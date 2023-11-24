import 'package:test/test.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Init ffi loader if needed.
  sqfliteFfiInit();
  test('simple sqflite example', () async {
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    expect(await db.getVersion(), 0);
    await db.close();
  });

  // test('path sqflite test', () async {
  //   var databaseFactory = databaseFactoryFfi;
  //   final io.Directory appDocumentsDir =
  //       await getApplicationDocumentsDirectory();

  //   //Create path for database
  //   String dbPath = p.join(appDocumentsDir.path, "databases", "myDb.db");
  //   var db = await databaseFactory.openDatabase(
  //     dbPath,
  //   );

  //   await db.execute('''
  // CREATE TABLE Product (
  //     id INTEGER PRIMARY KEY,
  //     title TEXT
  // )
  // ''');
  //   await db.insert('Product', <String, Object?>{'title': 'Product 1'});
  //   await db.insert('Product', <String, Object?>{'title': 'Product 1'});

  //   var result = await db.query('Product');
  //   print(result);
  //   // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
  //   await db.close();
  // });
}
