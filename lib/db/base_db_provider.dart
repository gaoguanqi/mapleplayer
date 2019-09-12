import 'package:mapleplayer/db/sql_manager.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

/**
 * 创建一个父类 主要应用于 获取表名 判断表是否存在等
 */
abstract class BaseDbProvider {
  //默认不存在
  bool isTableExits = false;

  createTableString();

  tableName();

  //创建表sql语句
  String tableBaseString(String sql) => sql;

  Future<Database> getDataBase() async => await open();

  ///super 函数对父类进行初始化
  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), createTableString());
    }
    return await SqlManager.getCurrentDatabase();
  }
}
