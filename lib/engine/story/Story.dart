import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/cmp/AssetPath.dart';
import 'package:fquest_engine/cmp/Serializer.dart';
import 'package:fquest_engine/cmp/ast/global/GlobalNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/prog/ProgNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/scene/SceneNode.dart';

class _Prog extends StateNotifier<GlobalNode?> {
  _Prog() : super(null);

  setStory(GlobalNode? progNode) {
    state = progNode;
  }

  Future<SceneNode> loadScene(String label) async {
    final sceneNode = await rootBundle.loadString(AssetPath.COMPILED_AST_SCENES + label + '.ast');
    final scene = SceneNode.fromJson(jsonDecode(sceneNode));

    return scene;
  }

  Future<GlobalNode> loadInitialProg() async {
    final startModel = await loadScene('start');
    
    final globalNode = await rootBundle.loadString(AssetPath.COMPILED_AST_GLOBAL + 'global.ast');
    final global = GlobalNode.fromJson(jsonDecode(globalNode));

    (global.topLevelNode as ProgNode).prog.add(startModel);

    state = global;
    return global;
  }
}

class Story {
  static final prog = StateNotifierProvider<_Prog, GlobalNode?>((ref) {
    return _Prog();
  });
}
