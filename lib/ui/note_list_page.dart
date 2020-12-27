import 'package:flutter/material.dart';
import 'add_note_page.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final List<String> _allNotes = <String>['Welcome to Simple Notes App'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Notes App'),
        actions: [
          IconButton(icon: Icon(Icons.note_add),
              onPressed:  () {
                _navigateToAddNotePage(context);
              }),
        ],
      ),
      body: _buildNoteList(),
    );
  }

  _navigateToAddNotePage(BuildContext context) async {
    final String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage()),
    );

    if(result != null && result.isNotEmpty) {
      _addItemToList(result);
    }
  }

  Widget _buildNoteList() {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: _allNotes.length,
      itemBuilder: (context, index) {
        return _buildRow(_allNotes[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  void _addItemToList(item){
    setState(() {
      _allNotes.add(item);
    });
  }

  Widget _buildRow(String item) {
      return ListTile(
        title: Text(item),
        leading: Icon(
          Icons.note
        ),
        onTap: () {

        },
      );
    }
}
