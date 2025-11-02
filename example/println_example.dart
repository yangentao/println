import 'package:println/println.dart';

void main() {
  PrintlnConfig.separator = "--";
  // normal
  String s = println(1, 2, 3, name: "entao", score: 9); // 1, 2, 3, name:entao, score:9
  print("s is: $s");
  // with separator
  println(1, 2, 3, name: "entao", score: 9, $sep: "| "); // 1| 2| 3, name:entao, score:9

  // with $level parameter, output with color
  println($level: "e", 2, 3, name: "Tom"); // 2, 3, name:Tom    --red
  println($level: "w", 2, 3); // 2, 3 --yellow

  // output to StringSink
  StringBuffer buf = StringBuffer();
  println(1, 2, 3, name: "entao", score: 9, $sink: buf); // no output
  print(buf.toString()); // 1, 2, 3, name:entao, score:9
}
