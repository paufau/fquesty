import 'package:fquest_engine/cmp/streams/TokenStream.dart';

import '../../streams/UuidStream.dart';
import 'ParserHelper.dart';

class BaseParser {
  BaseParser({required this.tokenStream}) {
    helper = ParserHelper(tokenStream: tokenStream);
  }

  UuidStream uuid = UuidStream();
  TokenStream tokenStream;
  late ParserHelper helper;
}
