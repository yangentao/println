part of '../println.dart';

// https://en.wikipedia.org/wiki/ANSI_escape_code

class EscapeCode {
  static final EscapeCode reset = EscapeCode("0");
  static final EscapeCode bold = EscapeCode("1");
  static final EscapeCode faint = EscapeCode("2");
  static final EscapeCode italic = EscapeCode("3");
  static final EscapeCode underline = EscapeCode("4");
  static final EscapeCode slowBlink = EscapeCode("5");
  static final EscapeCode rapidBlink = EscapeCode("6");
  static final EscapeCode invert = EscapeCode("7");
  static final EscapeCode hide = EscapeCode("8");
  static final EscapeCode strike = EscapeCode("9");
  static final EscapeCode primary = EscapeCode("10");
  static final EscapeCode fraktur = EscapeCode("20");
  static final EscapeCode notBlod = EscapeCode("21");
  static final EscapeCode normalIntensity = EscapeCode("22");
  static final EscapeCode notItalic = EscapeCode("23");
  static final EscapeCode notUnderlined = EscapeCode("24");
  static final EscapeCode notBliking = EscapeCode("25");
  static final EscapeCode proportionalSpacing = EscapeCode("26");
  static final EscapeCode notReversed = EscapeCode("27");
  static final EscapeCode reveal = EscapeCode("28");
  static final EscapeCode notCrossedOut = EscapeCode("29");
  static final EscapeCode foreBlack = EscapeCode("30");
  static final EscapeCode foreRed = EscapeCode("31");
  static final EscapeCode foreGreen = EscapeCode("32");
  static final EscapeCode foreYellow = EscapeCode("33");
  static final EscapeCode foreBlue = EscapeCode("34");
  static final EscapeCode foreMagenta = EscapeCode("35");
  static final EscapeCode foreCyan = EscapeCode("36");
  static final EscapeCode foreWhite = EscapeCode("37");
  static final EscapeCode foreDefault = EscapeCode("39");
  static final EscapeCode backBlack = EscapeCode("40");
  static final EscapeCode backRed = EscapeCode("41");
  static final EscapeCode backGreen = EscapeCode("42");
  static final EscapeCode backYellow = EscapeCode("43");
  static final EscapeCode backBlue = EscapeCode("44");
  static final EscapeCode backMagenta = EscapeCode("45");
  static final EscapeCode backCyan = EscapeCode("46");
  static final EscapeCode backWhite = EscapeCode("47");
  static final EscapeCode backDefault = EscapeCode("49");
  static final EscapeCode noProportionalSpacing = EscapeCode("50");
  static final EscapeCode framed = EscapeCode("51");
  static final EscapeCode encircled = EscapeCode("52");
  static final EscapeCode overlined = EscapeCode("53");
  static final EscapeCode noFramed = EscapeCode("54");
  static final EscapeCode noOverlined = EscapeCode("55");
  static final EscapeCode defaultUndlerlineColor = EscapeCode("59");
  static final EscapeCode foreBlackBright = EscapeCode("90");
  static final EscapeCode foreRedBright = EscapeCode("91");
  static final EscapeCode foreGreenBright = EscapeCode("92");
  static final EscapeCode foreYellowBright = EscapeCode("93");
  static final EscapeCode foreBlueBright = EscapeCode("94");
  static final EscapeCode foreMagentaBright = EscapeCode("95");
  static final EscapeCode foreCyanBright = EscapeCode("96");
  static final EscapeCode foreWhiteBright = EscapeCode("97");
  static final EscapeCode backBlackBright = EscapeCode("100");
  static final EscapeCode backRedBright = EscapeCode("101");
  static final EscapeCode backGreenBright = EscapeCode("102");
  static final EscapeCode backYellowBright = EscapeCode("103");
  static final EscapeCode backBlueBright = EscapeCode("104");
  static final EscapeCode backMagentaBright = EscapeCode("105");
  static final EscapeCode backCyanBright = EscapeCode("106");
  static final EscapeCode backWhiteBright = EscapeCode("107");

  final String code;

  const EscapeCode(this.code);

  @override
  String toString() {
    return code;
  }

  EscapeCode foreColor({required int r, required int g, required int b}) => EscapeCode("38;2;$r;$g;$b");

  EscapeCode backColor({required int r, required int g, required int b}) => EscapeCode("48;2;$r;$g;$b");

  EscapeCode underlineColor({required int r, required int g, required int b}) => EscapeCode("58;2;$r;$g;$b");

  static String styled({required String text, List<EscapeCode>? style}) {
    if (style == null || style.isEmpty) return text;
    String st = style.map((e) => e.code).join(";");
    return "\u001b[${st}m$text\u001b[0m";
  }
}

extension EscapeStyledExt on String {
  String styleEscaped(List<EscapeCode>? style) {
    return EscapeCode.styled(text: this, style: style);
  }
}
