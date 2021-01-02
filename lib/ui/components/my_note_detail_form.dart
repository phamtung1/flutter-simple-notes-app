import 'package:flutter/material.dart';

class MyNoteDetailForm extends Form {
  MyNoteDetailForm(
      {GlobalKey<FormState> key,
      TextEditingController titleController,
      TextEditingController contentController,
      bool readOnly = false,
      })
      : super(
            key: key,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    readOnly: readOnly,
                    controller: titleController,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      hintText: "Title",
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
                        readOnly: readOnly,
                        controller: contentController,
                        decoration: InputDecoration(
                          hintText: "Note"
                        ),
                        maxLines: 30,
                        keyboardType: TextInputType.multiline),
                  ),
                ],
              ),
            ));
}
