import 'package:floor/floor.dart';
import 'package:floor_example/app_dao.dart';
import 'package:floor_example/app_database.dart';

class DB {
  static AppDao? appDao;

  static getDatabaseObj() async {
    var callback = Callback(onCreate: (database, _) {
      String sql =
          'INSERT INTO ProductTable(pname, price) VALUES("product1", 4500)';
      database.execute(sql);

      String sql2 = 'INSERT INTO Category(name) VALUES("Category1")';
      database.execute(sql2);
    });
    var db = await $FloorAppDatabase
        .databaseBuilder('my_data.db')
        .addCallback(callback)
        .build();

    appDao = db.appdao;
    return appDao;
  }
}
