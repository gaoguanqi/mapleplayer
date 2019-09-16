import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapleplayer/view/home_page.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/splash.mp4")
    // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {
          // 视频为播放状态
          _controller.play();
          // 循环播放
          _controller.setLooping(true);
        });
      });
    //startHome();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }

    return Scaffold(
      body: Image.asset(
        "assets/images/launch_image.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  startHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}