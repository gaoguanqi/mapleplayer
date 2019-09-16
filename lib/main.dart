import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapleplayer/view/splash_page.dart';

void main() {
  runApp(MyApp());
  //设置状态栏透明
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white,
          platform: TargetPlatform.iOS //右滑返回
      ),
      home: SplashPage(),
    );
  }
}
