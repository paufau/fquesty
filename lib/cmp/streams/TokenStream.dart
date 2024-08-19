import 'package:fquest_engine/cmp/streams/Keywords.dart';
import 'package:fquest_engine/cmp/streams/SymbolStream.dart';
import 'package:fquest_engine/cmp/streams/Token.dart';

class TokenStream {
  TokenStream({required this.symbolStream});

  Token? current;
  List<String> keywords = KeywordsMap.values.toList(growable: false);
  SymbolStream symbolStream;

  bool isKeyword(String word) {
    return keywords.indexWhere((element) => element == word) != -1;
  }

  bool isDigit(String char){
    return RegExp(r'^\d+$').hasMatch(char);
  }

  bool isIdStart(String char) {
    return RegExp(r'[a-zA-Z_]').hasMatch(char);
  }

  bool isId(String char) {
    return isIdStart(char) || RegExp(r'\d').hasMatch(char);
  }

  bool isOperation(String char) {
    return RegExp(r'[+\-*/&|<>!=]').hasMatch(char);
  }

  bool isPunctuation(String char) {
    return RegExp(r'[,;:(){\}\[\]]').hasMatch(char);
  }

  bool isWhitespace(String char) {
    return ' \t\n'.contains(char);
  }

  String readWhile(bool Function(String) predicate) {
    String str = '';
    while (!symbolStream.isEmpty() && predicate(symbolStream.peek()!)) {
      final char = symbolStream.next();
      if (char != null) {
        str += char;
      }
    }
    return str;
  }

  Token readNumber(){
    bool hasDot = false;
    String num = readWhile((char){
      if (char == '.') {
        if (hasDot) return false;
        hasDot = true;
        return true;
      }
      return isDigit(char);
    });
    return Token(type: ETokenType.NUM, value: double.parse(num));
  }

  Token readId() {
    String id = readWhile(isId);
    return Token(type: isKeyword(id) ? ETokenType.KW : ETokenType.VAR, value: id);
  }

  String readEscaped(String endChar) {
    bool isEscaped = false;
    String str = '';
    symbolStream.next();
    while (!symbolStream.isEmpty()) {
      String char = symbolStream.next()!;
      if (isEscaped) {
        str += char;
        isEscaped = false;
      } else if (char == '\\') {
        isEscaped = true;
      } else if (char == endChar) {
        break;
      } else {
        str += char;
      }
    }
    return str;
  }

  Token readString () {
    return Token(type: ETokenType.STR, value: readEscaped('"'));
  }

  void skipComment () {
    // TODO
  }

  Token? readNext () {
    readWhile(isWhitespace);
    if (symbolStream.isEmpty()) return null;
    String? char = symbolStream.peek();
    if (char != null) {
      if (char == '#') {
        skipComment();
        return readNext();
      }
      if (char == '"') return readString();
      if (isDigit(char)) return readNumber();
      if (isIdStart(char)) return readId();
      if (isPunctuation(char)) return Token(type: ETokenType.PUNC, value: symbolStream.next());
      if (isOperation(char)) return Token(type: ETokenType.OP, value: readWhile(isOperation));
    }
    symbolStream.error(msg: 'Cant hangle character: $char');
    return null;
  }

  Token? peek () {
    current ??= readNext();
    return current;
  }

  Token? next () {
    Token? token = current;
    print(token);
    current = null;
    if (token != null) {
      return token;
    }
    return readNext();
  }

  bool isEmpty () {
    return peek() == null;
  }

  void error (String msg) {
    symbolStream.error(msg: msg);
  }
}