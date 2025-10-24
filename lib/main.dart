import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage/components/state_app_demo_widget.dart';
import 'package:flutter_storage/db/service/db_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //проверка что все инициализировано
  WidgetsFlutterBinding.ensureInitialized();
  DBService.instance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StateAppDemoWidget(),
    );
  }
}

