import 'package:mapleplayer/db/user_db_provider.dart';
import 'package:mapleplayer/db/user_info.dart';

void main(){

  UserInfo info = UserInfo();
  info.userId = "123456";
  info.userName = "张三";
  info.userPhone = "13717591366";




  UserDbProvider provider = UserDbProvider();
  provider.insert(info);


  var  maps = provider.getUserInfo("123456");

  print(maps.toString());
}