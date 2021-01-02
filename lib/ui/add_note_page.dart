import 'package:flutter/material.dart';
import 'package:simple_notes_app/helpers/ui-helper.dart';
import 'package:simple_notes_app/models/note-item.dart';
import 'package:simple_notes_app/helpers/data-helper.dart';

import 'components/my_note_detail_form.dart';

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

  Color _currentColor = Colors.white;

  void _onChangeColor(Color color) => setState(() => _currentColor = color);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_titleInputController.text.isEmpty &&
            _contentInputController.text.isEmpty) {
          Navigator.pop(context);
          return Future.value(false);
        }

        if (_formKey.currentState.validate()) {
          var note = NoteItem(
              title: _titleInputController.text,
              content: _contentInputController.text,
              colorValue: _currentColor == null ? Theme.of(context).canvasColor.value : _currentColor.value);

          var id = await DataHelper.addNote(note);
          note.id = id;

          Navigator.pop(context, note);
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: _currentColor,
        appBar: AppBar(
          title: Text('Add New Note'),
          actions: [
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () async {
                UIHelper.showColorDialog(
                    context: context,
                    pickerColor: _currentColor,
                    onColorChanged: _onChangeColor);
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: MyNoteDetailForm(
            key: _formKey,
            titleController: _titleInputController,
            contentController: _contentInputController,
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleInputController.dispose();
    super.dispose();
  }
}
