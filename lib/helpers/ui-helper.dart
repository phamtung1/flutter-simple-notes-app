import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class UIHelper {
  static void showColorDialog(
      {BuildContext context,
      Color pickerColor,
      ValueChanged<Color> onColorChanged}) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select colors'),
          content: SingleChildScrollView(
            child: BlockPicker(
              availableColors: [
                Theme.of(context).canvasColor,
                Color(0xFFe0e0e0),
                Colors.lightBlueAccent,
                Colors.amberAccent,
                Colors.greenAccent,
                Colors.yellowAccent
              ],
              pickerColor: pickerColor == null ? Theme.of(context).canvasColor : pickerColor,
              onColorChanged: onColorChanged,
            ),
          ),
        );
      },
    );
  }

  static void showConfirm({
    BuildContext context,
    VoidCallback onOKPressed,
    String title,
    String message,
  }) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context); // dismiss dialog
      },
    );
    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed: onOKPressed,
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
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
