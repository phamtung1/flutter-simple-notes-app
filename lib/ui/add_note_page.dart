import 'package:flutter/material.dart';

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
        if (_contentInputController.text.isEmpty || _formKey.currentState.validate()) {
          Navigator.pop(context, _titleInputController.text);
        }

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add a Note'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child:  SingleChildScrollView(
            child: _buildForm()
          ),
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
                decoration: InputDecoration(
                  hintText: "Note"
                ),
                maxLines: 30,
                keyboardType: TextInputType.multiline
              ),
          ),
        ],
      ),
    );
  }
}