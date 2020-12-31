import 'package:flutter/material.dart';

class CustomDrawer extends Drawer {
  CustomDrawer(
      {BuildContext context,
        GestureTapCallback onTapNotes,
        GestureTapCallback onTapTrash,
        int selectedIndex
      })
      : super(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 100.0,
          child: DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Simple Notes App', style: TextStyle(color: Colors.white)),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue
              ),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0)
          ),
        ),
        ListTile(
          title: Text('Notes'),
          tileColor: selectedIndex == 0 ? Colors.grey : Theme.of(context).selectedRowColor,
          onTap: onTapNotes
        ),
        ListTile(
          title: Text('Trash'),
          tileColor: selectedIndex == 1 ? Colors.grey : Theme.of(context).canvasColor,
          onTap: onTapTrash,
        ),
      ],
    ),
  );
}
