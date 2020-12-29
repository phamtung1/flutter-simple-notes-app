class StringUtils {

  static String truncateWithEllipsis(String myString, [int cutoff = 20]) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
}
