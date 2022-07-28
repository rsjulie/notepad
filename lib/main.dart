import 'package:flutter/material.dart';
import 'package:notepad/app/core/database/tables.dart';
import 'package:notepad/app/pages/home/home.dart';
import 'package:notepad/app/provider/notepad_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<MyDatabase>(
      create: (context) => MyDatabase(),
      child: const MyApp(),
      dispose: (context, db) => db.close(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotepadProvider>(
      create: (context) => NotepadProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notepad',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const HomePage(),
      ),
    );
  }
}
