import 'dart:convert';

import 'ast/nodes/prog/ProgNode.dart';

class Serializer {
  ProgNode deserializeAst(String json) {
    return ProgNode.fromJson(jsonDecode(json));
  }
}
