import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:simple_notes_app/helpers/string-helper.dart';

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
          content: SizedBox(
            height: 210,
            child: BlockPicker(
              availableColors: [
                Theme.of(context).canvasColor,
                StringHelper.getColorFromHexCode('#F2D7D5'),
                StringHelper.getColorFromHexCode('#FADBD8'),
                StringHelper.getColorFromHexCode('#EBDEF0'),
                StringHelper.getColorFromHexCode('#D4E6F1'),
                StringHelper.getColorFromHexCode('#D1F2EB'),
                StringHelper.getColorFromHexCode('#D5F5E3'),
                StringHelper.getColorFromHexCode('#FCF3CF'),
                StringHelper.getColorFromHexCode('#F6DDCC'),

                StringHelper.getColorFromHexCode('#F1948A'),
                StringHelper.getColorFromHexCode('#AF7AC5'),
                StringHelper.getColorFromHexCode('#5DADE2'),
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
