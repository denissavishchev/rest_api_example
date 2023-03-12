import 'package:flutter/material.dart';
import 'package:rest_api_example/views/note_list.dart';
import 'future_builder_fetch.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: NoteList());
  }
}
