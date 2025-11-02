part of '../println.dart';

class PrintlnCall {
  PrintlnConfig config;
  final void Function(List<dynamic> argList, Map<String, dynamic> argMap)? before;
  final void Function(String result)? after;

  PrintlnCall({this.before, this.after, PrintlnConfig? config}) : config = config ?? PrintlnConfig();

  String _doPrint(List<dynamic> ls, Map<String, dynamic> map) {
    String sep = map["\$sep"] ?? config.separator;
    String? level = map["\$level"];
    StringSink? buf = map["\$sink"];
    if (buf != null) {
      String line = _buildLine(ls, map, sep: sep);
      buf.writeln(line);
      return line;
    }
    if (_isReleaseMode && !config.releaseOn) return "";
    if (_isDebugMode && !config.debugOn) return "";

    String line = _buildLine(ls, map, sep: sep);
    if (level == "e" || level == "error") {
      line = line.styleEscaped([EscapeCode.foreRed]);
    } else if (level == "w" || level == "warn" || level == "warning") {
      line = line.styleEscaped([EscapeCode.foreYellowBright]);
    } else if (config.style != null) {
      line = line.styleEscaped(config.style);
    }
    print(line);
    return line;
  }

  String _buildLine(List<dynamic> ls, Map<String, dynamic> map, {required String sep}) {
    String a = ls.map((e) => e.toString()).join(sep);
    String b = map.entries.where((e) => !e.key.startsWith("\$")).map((e) => "${e.key}${config.keyValueSeparator}${e.value}").join(config.entrySeparator);
    if (a.isEmpty) return b;
    if (b.isEmpty) return a;
    return "$a${config.listMapSeparator}$b";
  }

  String call() {
    return _invoke([], {});
  }

  //Symbol("x") => x
  String _symbolText(Symbol sym) {
    String s = sym.toString();
    return s.substring(8, s.length - 2);
  }

  @override
  String noSuchMethod(Invocation invocation) {
    List<dynamic> argList = invocation.positionalArguments.toList();
    Map<String, dynamic> argMap = invocation.namedArguments.map((sym, v) {
      return MapEntry(_symbolText(sym), v);
    });
    return _invoke(argList, argMap);
  }

  String _invoke(List<dynamic> argList, Map<String, dynamic> argMap) {
    before?.call(argList, argMap);
    String r = _doPrint(argList, argMap);
    after?.call(r);
    return r;
  }
}

const bool _isReleaseMode = bool.fromEnvironment('dart.vm.product') || bool.fromEnvironment('dart.vm.profile');
const bool _isDebugMode = !_isReleaseMode;
