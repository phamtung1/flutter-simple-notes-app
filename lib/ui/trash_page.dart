import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/note-item.dart';
import 'package:flutter_app/ui/update_note_page.dart';
import 'package:flutter_app/utils/data-access.dart';
import 'package:flutter_app/utils/string-utils.dart';
import 'add_note_page.dart';

class TrashPage extends StatefulWidget {
  @override
  _TrashPageState createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NoteItem>>(
        future: DataAccess.getAllDeletedNotes(),
        builder: (context, AsyncSnapshot<List<NoteItem>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Trash'),
                actions: <Widget>[
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      _showConfirmEmptyTrash(context);
                    },
                    child: Text("Empty Trash"),
                    shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                  ),
                ],
              ),
              body: _buildNoteList(snapshot.data),
              drawer: _buildDrawer(context),
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

  Widget _buildNoteList(List<NoteItem> notes) {
    if(notes.isEmpty){
      return Center(
        child: Text('Trash is empty')
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return _buildRow(notes[index]);
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
    );
  }

  Widget _buildDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
        Container(
        height: 100.0,
        child: DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Simple Notes App', style: TextStyle(color: Colors.white)),
            ),
            decoration: BoxDecoration(
                color: Colors.blue
            ),
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0)
        ),
      ),
         WillPopScope(onWillPop: () async => false,
             child: ListTile(
               title: Text('Notes'),
               onTap: () {
                 Navigator.pop(context);
                 Navigator.pop(context);
               },
             ),
         ),
          ListTile(
            title: Text('Trash'),
              tileColor: Colors.grey,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }


  void _showConfirmEmptyTrash(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context); // dismiss dialog
      },
    );
    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed: () async {
        await DataAccess.emptyTrash();
        Navigator.pop(context); // dismiss dialog
        setState(() { });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Empty Trash"),
      content: Text("Are you sure you want to permanently delete all notes in the trash?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }
}
