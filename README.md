## println
output messages with variant arguments, and color.

```dart
import 'package:println/println.dart';
import 'package:println/src/ascii_escape.dart';
import 'package:test/test.dart';

void main() {
  test("normal", () {
    println(1, 2, 3, name: "entao", addr: "jinan");
    // 1 2 3, addr:jinan, name:entao
    println(addr: "jinan", 1, 2, 3, name: "entao");
    // 1 2 3, addr:jinan, name:entao
  });

  test("arguments", () {
    println($level: "e", 1, 2, 3, name: "entao", addr: "jinan");
    // 1 2 3, addr:jinan, name:entao   ----red color
    println($level: "w", addr: "jinan", 1, 2, 3, name: "entao");
    // 1 2 3, addr:jinan, name:entao   -----yellow color

    println(1, 2, 3, name: "entao", score: 9, $sep: "| ");
    // 1| 2| 3, name:entao, score:9
  });

  test("sink", () {
    // output to StringSink
    StringBuffer buf = StringBuffer();
    println(1, 2, 3, name: "entao", score: 9, $sink: buf); // no output
    print(buf.toString());
    // 1 2 3, name:entao, score:9
  });

  test("config", () {
    PrintlnConfig config = println.config;
    config.separator = "--";
    config.keyValueSeparator = "=";
    config.debugOn = true ;
    config.releaseOn = true ;
    config.style = [EscapeCode.foreGreen, EscapeCode.backBlack];

    println(1, 2, 3, name: "entao", score: 9);
    // 1--2--3, name=entao, score=9     ---green color
  });
}

```
