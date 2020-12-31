class StringHelper {

  static String truncateWithEllipsis(String myString, [int cutoff = 20]) {
    var result = (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';

    return result.replaceAll("\n", " ");
  }
}
