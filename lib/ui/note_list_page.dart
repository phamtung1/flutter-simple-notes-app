import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/note-item.dart';
import 'package:flutter_app/ui/update_note_page.dart';
import 'package:flutter_app/utils/data-access.dart';
import 'package:flutter_app/utils/string-utils.dart';
import 'add_note_page.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final List<NoteItem> _allNotes = <NoteItem>[];

  @override
  void initState() {
    DataAccess.getAllWithTruncatedContent().then((value) => () {
          setState(() {
            _allNotes.addAll(value);
          });
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: _buildNoteList(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Simple Notes App'),
                actions: [
                  IconButton(
                      icon: Icon(Icons.note_add),
                      onPressed: () {
                        _navigateToAddNotePage(context);
                      }),
                ],
              ),
              body: snapshot.data,
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Simple Notes App'),
                ),
                body: _buildLoadingScreen(context));
          }
        });
  }

  Widget _buildLoadingScreen(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 100,
      height: 100,
      child: new Column(
        children: [
          CircularProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey,
          ),
          Container(margin: EdgeInsets.only(top: 15), child: Text("Loading")),
        ],
      ),
    ));
  }

  _navigateToAddNotePage(BuildContext context) async {
    final NoteItem result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage()),
    );

    if (result != null && result.title.isNotEmpty) {
      _addNote(result);
    }
  }

  Future<Widget> _buildNoteList() async {
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

  Widget _buildRow(NoteItem note) {
    return ListTile(
      key: ValueKey(note.id),
      title: Text(note.title),
      subtitle: Text(note.content),
      leading: Icon(Icons.note),
      onTap: () async {
        final NoteItem result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateNotePage(noteId: note.id)),
        );
        _updateNote(result);
      },
    );
  }

  void _addNote(NoteItem note) {
    setState(() {
      _allNotes.add(note);
    });
  }

  void _updateNote(NoteItem note) {
    int index = _allNotes.indexWhere((element) => element.id == note.id);
    if (index < 0) {
      return;
    }

    if (note.deleted == true) {
      // delete
      setState(() {
        _allNotes.removeAt(index);
      });
    } else {
      // update
      note.content = StringUtils.truncateWithEllipsis(note.content);
      setState(() {
        _allNotes[index] = note;
      });
    }
  }
}
