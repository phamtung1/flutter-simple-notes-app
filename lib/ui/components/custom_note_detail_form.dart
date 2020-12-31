import 'package:flutter/material.dart';

class CustomNoteDetailForm extends Form {
  CustomNoteDetailForm(
      {GlobalKey<FormState> key,
      TextEditingController titleController,
      TextEditingController contentController,
      bool readOnly = false})
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
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: const OutlineInputBorder(),
                      filled: readOnly
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
                          hintText: "Note",
                          border: const OutlineInputBorder(),
                          filled: readOnly
                        ),
                        maxLines: 30,
                        keyboardType: TextInputType.multiline),
                  ),
                ],
              ),
            ));
}
