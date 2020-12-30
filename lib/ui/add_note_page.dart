import 'package:flutter/material.dart';
import 'package:flutter_app/models/note-item.dart';
import 'package:flutter_app/utils/data-access.dart';

class AddNotePage extends StatefulWidget {
  @override
  AddNotePageState createState() {
    return AddNotePageState();
  }
}

class AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleInputController = TextEditingController();
  final _contentInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_titleInputController.text.isEmpty && _contentInputController.text.isEmpty){
          Navigator.pop(context);
          return Future.value(false);
        }

        if (_formKey.currentState.validate()) {
          var note = NoteItem(
              title: _titleInputController.text,
              content: _contentInputController.text);

          var id = await DataAccess.addNote(note);
          note.id = id;

          Navigator.pop(context, note);
        }

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Note'),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    controller: _contentInputController,
                    decoration: InputDecoration(
                      hintText: "Note",
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 30,
                    keyboardType: TextInputType.multiline),
              ),
            ],
          ),
        ));
  }
}
