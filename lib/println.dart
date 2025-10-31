library;

class PrintlnConfig {
  static bool releasePrintln = false;
  static bool debugPrintln = true;
  static String separator = " ";
  static String keyValueSeparator = ":";
  static String mapEntrySeparator = ", ";
  static String listMapSeparator = ", ";
}

dynamic println = PrintlnCall<String>(callback: _doPrint);

String _doPrint(List<dynamic> ls, Map<String, dynamic> map) {
  String sep = map["\$sep"] ?? PrintlnConfig.separator;
  String? level = map["\$level"];
  StringSink? buf = map["\$sink"];
  if (buf != null) {
    String line = _buildLine(ls, map, sep: sep);
    buf.writeln(line);
    return line;
  }
  if (_isReleaseMode && !PrintlnConfig.releasePrintln) return "";
  if (_isDebugMode && !PrintlnConfig.debugPrintln) return "";

  String line = _buildLine(ls, map, sep: sep);
  if (level == "e" || level == "error") {
    line = "\u001b[31m$line\u001b[0m";
  } else if (level == "w" || level == "warn" || level == "warning") {
    line = "\u001b[33m$line\u001b[0m";
  }
  print(line);
  return line;
}

String _buildLine(List<dynamic> ls, Map<String, dynamic> map, {required String sep}) {
  String a = ls.map((e) => e.toString()).join(sep);
  String b = map.entries.where((e) => !e.key.startsWith("\$")).map((e) => "${e.key}${PrintlnConfig.keyValueSeparator}${e.value}").join(PrintlnConfig.mapEntrySeparator);
  if (a.isEmpty) return b;
  if (b.isEmpty) return a;
  return "$a${PrintlnConfig.listMapSeparator}$b";
}

const bool _isReleaseMode = bool.fromEnvironment('dart.vm.product') || bool.fromEnvironment('dart.vm.profile');
const bool _isDebugMode = !_isReleaseMode;

class PrintlnCall<R> {
  final R Function(List<dynamic> argList, Map<String, dynamic> argMap) callback;
  final void Function(List<dynamic> argList, Map<String, dynamic> argMap)? before;
  final void Function(R result)? after;

  PrintlnCall({required this.callback, this.before, this.after});

  R call() {
    return invoke([], {});
  }

  //Symbol("x") => x
  String _symbolText(Symbol sym) {
    String s = sym.toString();
    return s.substring(8, s.length - 2);
  }

  @override
  R noSuchMethod(Invocation invocation) {
    List<dynamic> argList = invocation.positionalArguments.toList();
    Map<String, dynamic> argMap = invocation.namedArguments.map((sym, v) {
      return MapEntry(_symbolText(sym), v);
    });
    return invoke(argList, argMap);
  }

  R invoke(List<dynamic> argList, Map<String, dynamic> argMap) {
    before?.call(argList, argMap);
    R r = callback(argList, argMap);
    after?.call(r);
    return r;
  }
}
