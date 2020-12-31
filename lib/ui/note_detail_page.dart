import 'package:flutter/material.dart';
import 'package:flutter_app/models/note-item.dart';
import 'package:flutter_app/utils/data-access.dart';

import 'components/custom_note_detail_form.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  NoteDetailPage({this.noteId});

  @override
  NoteDetailPageState createState() {
    return NoteDetailPageState(noteId: this.noteId);
  }
}

class NoteDetailPageState extends State<NoteDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleInputController = TextEditingController();
  final _contentInputController = TextEditingController();

  NoteItem _note;

  final int noteId;

  NoteDetailPageState({this.noteId});

  @override
  void initState() {
    DataAccess.getSingle(noteId).then((value) => {
          setState(() {
            _note = value;
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Note Details'),
          actions: [
            IconButton(
                icon: Icon(Icons.restore),
                onPressed: () async {
                  _restoreNote(context);
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showConfirmDelete(context);
                }),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(child: _buildForm()),
        ),
    );
  }

  Widget _buildForm() {
    if (_note != null) {
      _titleInputController.text = _note.title;
      _contentInputController.text = _note.content;
    }
    return CustomNoteDetailForm(
      key: _formKey,
      titleController: _titleInputController,
      contentController: _contentInputController,
      readOnly: true,
    );
  }

  Future<void> _restoreNote(BuildContext context) async {
      _note.deleted = null;
      await DataAccess.update(_note);
      Navigator.pop(context, _note);
  }

  void _showConfirmDelete(BuildContext context) {
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
        await DataAccess.delete(_note.id);
        Navigator.pop(context); // dismiss dialog
        Navigator.pop(context, _note); // back to previous page
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to permanently delete this note from the trash?"),
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
