import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyUtils {

  static String truncateWithEllipsis(String myString, [int cutoff = 20]) {
    var result = (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';

    return result.replaceAll("\n", " ");
  }

  static String formatDate(int millisecondsSinceEpoch, String format){
    if(millisecondsSinceEpoch == null)
      {
        return '';
      }

    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat(format).format(date);
  }

  /// @code: hex code, #ffffff
  static Color getColorFromHexCode(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
