enum ETokenType {
 PUNC,
 NUM,
 STR,
 KW,
 VAR,
 OP
}

class Token {
  Token({required this.type, required this.value});

  ETokenType type;
  dynamic value;

  @override
  String toString() {
    return '{type: $type; value: $value}';
  }
}