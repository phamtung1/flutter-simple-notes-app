import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringHelper {

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
}
