part of '../println.dart';

class PrintlnConfig {
  List<EscapeCode>? style;
  bool debugOn;
  bool releaseOn;
  String separator;
  String keyValueSeparator;
  String entrySeparator;
  String listMapSeparator;

  PrintlnConfig(
      {this.style,
      this.debugOn = true,
      this.releaseOn = false,
      this.separator = " ",
      this.keyValueSeparator = ":",
      this.entrySeparator = ", ",
      this.listMapSeparator = ", "});
}
