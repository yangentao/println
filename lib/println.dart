library;

import 'package:any_call/any_call.dart';

dynamic println = AnyCall<void>(
  callback: (ls, map) {
    String sep = map["\$sep"] ?? ", ";
    String? level = map["\$level"];
    StringSink? buf = map["\$sink"];
    if (buf != null) {
      String line = _buildLine(ls, map, sep: sep);
      buf.writeln(line);
      return;
    }
    if (!_isDebugMode) return;
    String line = _buildLine(ls, map, sep: sep);
    if (level == "e" || level == "error") {
      line = "\u001b[31m$line\u001b[0m";
    } else if (level == "w" || level == "warn" || level == "warning") {
      line = "\u001b[33m$line\u001b[0m";
    }
    print(line);
  },
);

String _buildLine(List<dynamic> ls, Map<String, dynamic> map, {required String sep}) {
  String a = ls.map((e) => e.toString()).join(sep);
  String b = map.entries.where((e) => !e.key.startsWith("\$")).map((e) => "${e.key}:${e.value}").join(", ");
  if (a.isEmpty) return b;
  if (b.isEmpty) return a;
  return "$a, $b";
}

const bool _isDebugMode = !bool.fromEnvironment('dart.vm.product') && !bool.fromEnvironment('dart.vm.profile');
