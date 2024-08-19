import 'package:fquest_engine/cmp/streams/TokenStream.dart';

import '../../streams/Token.dart';

class ParserHelper {
  ParserHelper({required this.tokenStream});

  TokenStream tokenStream;

  void skipPunc(String? char) {
    if (isPunc(char) != null) {
      tokenStream.next();
    } else {
      tokenStream.error('Expecting punctuation "$char", gut getting "${tokenStream.peek()?.value}"');
    }
  }

  void skipKeyword(String? kw) {
    if (isKeyword(kw) != null) {
      tokenStream.next();
    } else {
      tokenStream.error('Expecting keyword $kw');
    }
  }

  void skipOperation(String? op) {
    if (isOperation(op) != null) {
      tokenStream.next();
    } else {
      tokenStream.error('Expecting operation: $op');
    }
  }

  Token? isOperation(String? char) {
    final t = tokenStream.peek();
    return t != null &&
            t.type == ETokenType.OP &&
            (char == null || t.value == char)
        ? t
        : null;
  }

  Token? isPunc(String? char) {
    final t = tokenStream.peek();
    return t != null &&
            t.type == ETokenType.PUNC &&
            (char == null || t.value == char)
        ? t
        : null;
  }

  Token? isKeyword(String? char) {
    final t = tokenStream.peek();
    return t != null &&
            t.type == ETokenType.KW &&
            (char == null || t.value == char)
        ? t
        : null;
  }

  Future<List<T>> delimited<T>(
      {required String start,
      required String stop,
      String? separator,
      required Future<T?> Function() parser}) async {
    List<T> actions = [];
    bool isFirst = true;

    skipPunc(start);

    while (!tokenStream.isEmpty()) {
      if (isPunc(stop) != null) break;
      if (isFirst) {
        isFirst = false;
      } else if (separator != null) {
        skipPunc(separator);
      }
      if (isPunc(stop) != null) break;

      final action = await parser();

      if (action != null) {
        actions.add(action);
      } else {
        tokenStream.error('Expecting parsed action');
      }
    }

    skipPunc(stop);

    return actions;
  }

  String parseVarName() {
    final t = tokenStream.next();
    if (t != null && t.type == ETokenType.VAR) {
      return t.value;
    } else {
      tokenStream.error('Expecting variable name');
    }
    return '';
  }


}
