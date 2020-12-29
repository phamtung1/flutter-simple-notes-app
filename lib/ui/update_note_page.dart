import 'package:flutter/material.dart';
import 'package:flutter_app/models/note-item.dart';
import 'package:flutter_app/utils/data-access.dart';

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
    super.initState();

    DataAccess.getSingle(noteId).then((value) => {
          setState(() {
            _note = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_contentInputController.text.isEmpty ||
            _formKey.currentState.validate()) {
          var note = NoteItem(
              id: noteId,
              title: _titleInputController.text,
              content: _contentInputController.text);

          await DataAccess.addNote(note);

          Navigator.pop(context, note);
        }

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Note'),
          actions: [
            IconButton(icon: Icon(Icons.delete), onPressed: () {}),
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

    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleInputController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                    controller: _contentInputController,
                    decoration: InputDecoration(hintText: "Note"),
                    maxLines: 30,
                    keyboardType: TextInputType.multiline),
              ),
            ],
          ),
        ));
  }
}
