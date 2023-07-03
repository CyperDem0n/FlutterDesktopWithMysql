import 'dart:io';

import 'package:basic_crud_stuff/views/main_menu/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter x Mysql');
    setWindowMaxSize(const Size(1600, 900));
    setWindowMinSize(const Size(1280, 720));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      child: MaterialApp(
        title: 'flutter app w mysql',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0x00ffd428),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Color(0xFF4E596F),
          ),
        ),
        home: const MainMenu(),
      ),
      builder: (context, child) {
        return child!;
      },
    );
  }
}
