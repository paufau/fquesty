import 'dart:io';

class ErrorService {
  static error ({String msg = '', int code = 2}) {
    if (msg.isNotEmpty) {
      stderr.writeln(msg);
    }
    exit(code);
  }
}