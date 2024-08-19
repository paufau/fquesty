
import 'package:fquest_engine/cmp/AstParser.dart';
import 'package:fquest_engine/cmp/ast/global/GlobalNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/scene/SceneNode.dart';

import 'cmp/services/FileService.dart';
import 'cmp/streams/SymbolStream.dart';
import 'cmp/streams/TokenStream.dart';

void main(List<String> args) async {
  final fileService = FileService();
  final text = await fileService.read();

  final symbolStream = SymbolStream(text: text);
  final tokenStream = TokenStream(symbolStream: symbolStream);

  final parser = AstParser(tokenStream: tokenStream);

  final topLevelNode = await parser.parseTopLevel();

  List<SceneNode> scenes = [];
  Set<String> sceneNames = {};

  for (var node in topLevelNode.prog) {
    if (node.type == ENodeType.SCENE) {
      scenes.add(node as SceneNode);
    }
  }

  await fileService.cleanBuild();

  for (var scene in scenes) {
    sceneNames.add(scene.name);
    topLevelNode.prog.remove(scene);
    await fileService.writeScene(scene);
  }

  final global = GlobalNode(scenes: sceneNames, topLevelNode: topLevelNode);

  await fileService.writeGlobal(global);
}
