import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ui/note_list_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: NoteListPage(),
    );
  }
}