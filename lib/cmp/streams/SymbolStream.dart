import 'dart:convert';
import 'dart:io';

import 'package:fquest_engine/cmp/services/ErrorService.dart';

class SymbolStream {
  SymbolStream({required this.text});

  String text;

  int pos = 0;
  int col = 0;
  int line = 1;

  String? next() {
    final char = text[pos];
    pos++;
    if (char == '\n') {
      line++;
      col = 0;
    } else {
      col++;
    }
    return char;
  }

  String? peek() {
    if (pos < text.length) {
      return text[pos];
    }
    return null;
  }

  bool isEmpty() {
    return peek() == '' || pos == text.length;
  }

  void error({String msg = ''}) {
    ErrorService.error(msg: '$msg: ($line:$col)');
  }
}
