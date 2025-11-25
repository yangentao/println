import 'package:println/println.dart';

void main() {
  println(1, 2, 3, name: "entao", addr: "jinan");
  // 1 2 3, addr:jinan, name:entao
  println(addr: "jinan", 1, 2, 3, name: "entao");
}
