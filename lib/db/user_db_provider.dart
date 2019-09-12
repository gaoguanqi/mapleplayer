import 'package:mapleplayer/db/base_db_provider.dart';
import 'package:mapleplayer/db/user_info.dart';
import 'package:sqflite/sqflite.dart';

/**
 * User表 增删改查 等方法
 *
 *  使用
 *   static insert() async{
      PersonDbProvider provider = new PersonDbProvider();
      UserModel userModel= UserModel();
      userModel.id=1143824942687547394;
      userModel.mobile="15801071158";
      userModel.headImage="http://www.img";
      provider.insert(userModel);
    }


    static update() async{
      PersonDbProvider provider = new PersonDbProvider();
      UserModel userModel= await provider.getPersonInfo(1143824942687547394);
      userModel.mobile="15801071157";
      userModel.headImage="http://www.img1";
      provider.update(userModel);
    }
 */
class UserDbProvider extends BaseDbProvider {
  //表名
  final String _tableName = 'UserInfo';

  //表字段
  final String userId = "userId";
  final String userName = "userName";
  final String userPhone = "userPhone";

  UserDbProvider();

  @override
  createTableString() {
    return '''
        create table $_tableName (
        $userId integer primary key,
        $userName text not null,
        $userPhone text not null)
      ''';
  }

  @override
  tableName() {
    return _tableName;
  }

  //查询数据库
  Future _getUserProvider(Database db,String id) async{
    List<Map<String,dynamic>> maps = await db.rawQuery("select * from $_tableName where $userId = $id");
    return maps;
  }

  //插入数据库
  Future insert(UserInfo user) async{
    Database db = await getDataBase();
    var userProvider = await _getUserProvider(db, user.userId);
    if(userProvider != null){
      //删除相同id 的用户
      await db.delete(_tableName,where: "$userId = ?", whereArgs: [user.userId]);
    }
    return await db.rawInsert("insert into $_tableName ($userId,$userName,$userPhone) values (?,?,?)",[user.userId,user.userName,user.userPhone]);
  }

  //更新数据库
  Future<void> update(UserInfo user) async{
    Database db = await getDataBase();
    await db.rawUpdate( "update $_tableName set $userId = ?,$userName = ? where $userPhone= ?",[user.userId,user.userName,user.userPhone]);
  }
  
  //获取事件数据
  Future<UserInfo> getUserInfo(String id) async{
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await _getUserProvider(db, id);
    if(maps.length > 0){
      return UserInfo.fromJson(maps[0]);
    }
    return null;
  }
}
