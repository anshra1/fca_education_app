void main() {
  String s = 'my';

  var c = s !is String;
  print(c);

  if (s is! String) {
    print(true);
  } else {
    print(false);
  }
}
