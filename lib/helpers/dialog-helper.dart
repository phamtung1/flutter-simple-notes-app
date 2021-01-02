import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:simple_notes_app/helpers/my-utils.dart';

class DialogHelper {
  static void showColorDialog(
      {BuildContext context,
      Color pickerColor,
      ValueChanged<Color> onColorChanged}) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: Text('Select colors'),
          content: SizedBox(
            height: 210,
            child: BlockPicker(
              availableColors: [
                Theme.of(context).canvasColor,
                MyUtils.getColorFromHexCode('#F2D7D5'),
                MyUtils.getColorFromHexCode('#FADBD8'),
                MyUtils.getColorFromHexCode('#EBDEF0'),
                MyUtils.getColorFromHexCode('#D4E6F1'),
                MyUtils.getColorFromHexCode('#D1F2EB'),
                MyUtils.getColorFromHexCode('#D5F5E3'),
                MyUtils.getColorFromHexCode('#FCF3CF'),
                MyUtils.getColorFromHexCode('#F6DDCC'),

                MyUtils.getColorFromHexCode('#F1948A'),
                MyUtils.getColorFromHexCode('#AF7AC5'),
                MyUtils.getColorFromHexCode('#5DADE2'),
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
