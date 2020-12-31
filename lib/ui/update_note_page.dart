import 'package:flutter/material.dart';
import 'package:simple_notes_app/helpers/ui-helper.dart';
import 'package:simple_notes_app/models/note-item.dart';
import 'package:simple_notes_app/helpers/data-helper.dart';

import 'components/custom_note_detail_form.dart';

class UpdateNotePage extends StatefulWidget {
  final int noteId;

  UpdateNotePage({this.noteId});

  @override
  UpdateNotePageState createState() {
    return UpdateNotePageState(noteId: this.noteId);
  }
}

class UpdateNotePageState extends State<UpdateNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleInputController = TextEditingController();
  final _contentInputController = TextEditingController();

  NoteItem _note;

  final int noteId;

  UpdateNotePageState({this.noteId});

  @override
  void initState() {
    DataHelper.getSingle(noteId).then((value) => {
          setState(() {
            _note = value;
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_formKey.currentState.validate()) {
          _note.title = _titleInputController.text;
          _note.content = _contentInputController.text;

          await DataHelper.update(_note);

          Navigator.pop(context, _note);
        }

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Note'),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  UIHelper.showConfirm(
                      context: context,
                      title: 'Delete',
                      message: 'Are you sure you want to delete this note?',
                    onOKPressed:  () async {
                      _note.deleted = 1;
                      await DataHelper.update(_note); // soft delete
                      Navigator.pop(context); // dismiss dialog
                      Navigator.pop(context, _note); // back to previous page
                    },
                  );
                }),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(child: _buildForm()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleInputController.dispose();
    super.dispose();
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
    );
  }
}
