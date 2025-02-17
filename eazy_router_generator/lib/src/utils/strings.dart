extension StringUtils on String {
  bool equal(String other) => compareTo(other) == 0;
  bool equalDifferentCase(String other) =>
      toLowerCase().equal(other.toLowerCase());
}
