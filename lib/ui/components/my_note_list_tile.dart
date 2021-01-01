import 'package:flutter/material.dart';
import 'package:simple_notes_app/helpers/string-helper.dart';
import 'package:simple_notes_app/models/note-item.dart';

class MyNoteListTile extends StatelessWidget {
   final NoteItem note;
   final GestureTapCallback onTap;

   MyNoteListTile({
    Key key,
    this.note,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: new Color(note.colorValue == null ? 0 : note.colorValue),
        key: ValueKey(note.id),
        title: Text(note.title),
        subtitle: Text(note.content),
        trailing: Text(
          StringHelper.formatDate(note.modifiedDate, 'dd MMM yyyy'),
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        onTap: onTap
      ),
    );
  }
}