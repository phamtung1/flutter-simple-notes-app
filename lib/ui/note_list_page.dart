import 'package:flutter/material.dart';
import 'package:flutter_app/models/note-item.dart';
import 'package:flutter_app/utils/data-access.dart';
import 'add_note_page.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final List<NoteItem> _allNotes = <NoteItem>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future:  _buildNoteList(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
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
              body: snapshot.data,
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }

  _navigateToAddNotePage(BuildContext context) async {
    final NoteItem result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage()),
    );

    if(result != null && result.title.isNotEmpty) {
      _addItemToList(result);
    }
  }

  Future<Widget> _buildNoteList() async{
    if(_allNotes.isEmpty) {
      var data = await DataAccess.getAllWithoutContent();
      _allNotes.addAll(data);
    }

    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: _allNotes.length,
      itemBuilder: (context, index) {
        return _buildRow(_allNotes[index].title);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  void _addItemToList (NoteItem note){
    DataAccess.addNote(note);
    setState(() {
      _allNotes.add(note);
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
