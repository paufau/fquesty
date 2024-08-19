import 'dart:convert';
import 'dart:io';

import 'package:fquest_engine/cmp/AssetPath.dart';
import 'package:fquest_engine/cmp/ast/global/GlobalNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/scene/SceneNode.dart';
import 'package:fquest_engine/cmp/services/ErrorService.dart';

class FileService {
  cleanBuild () async {
    return Directory(AssetPath.COMPILED_AST_GLOBAL).delete(recursive: true);
  }

  writeGlobal (GlobalNode node) async {
    await File(AssetPath.COMPILED_AST_GLOBAL + 'global.ast').create(recursive: true);
    await File(AssetPath.COMPILED_AST_GLOBAL + 'global.ast').writeAsString(jsonEncode(node));
  }

  writeScene (SceneNode node) async {
    await File(AssetPath.COMPILED_AST_SCENES + node.name + '.ast').create(recursive: true);
    await File(AssetPath.COMPILED_AST_SCENES + node.name + '.ast').writeAsString(jsonEncode(node));
  }

  write (String ast) async {
    const paths = ['assets/scenario/start.ast'];
    for (final path in paths) {
      File(path).writeAsString(ast);
    }
  }

  Future<List<String>> findPaths(String dir) async {
    final root = Directory(dir);
    final List<FileSystemEntity> entities = await root.list(recursive: true, followLinks: false).toList();
    List<String> scnFiles = [];
    for (var entity in entities) {
      final extension = entity.path.split('.').last;
      if (extension == 'scn') {
        scnFiles.add(entity.path);
      }
    }
    return scnFiles;
  }

  Future<String> read({bool showLineNumbers = false}) async {
    final paths = await findPaths(AssetPath.SCENARIO);

    String text = '';

    for (final path in paths) {
      final lines = utf8.decoder
          .bind(File(path).openRead())
          .transform(const LineSplitter());
      try {
        await for (final line in lines) {
          text += '$line\n' ;
        }
      } catch (_) {
        await _handleError(path);
      }
    }

    return text;
  }

  Future<void> _handleError(String path) async {
    if (await FileSystemEntity.isDirectory(path)) {
      ErrorService.error(msg: 'error: $path is a directory');
    } else {
      ErrorService.error(code: 1);
    }
  }
}