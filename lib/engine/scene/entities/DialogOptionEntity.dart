import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/dialog/option/DialogOptionNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/dialog/option/props/DialogOptionNodeProps.dart';
import 'package:fquest_engine/cmp/ast/nodes/speech/SpeechNode.dart';
import 'package:fquest_engine/engine/ast/interpreter/environment/Environment.dart';
import 'package:fquest_engine/engine/ast/interpreter/models/EvalResult.dart';

class DialogOptionEntity {
  static HashMap<SpeechNode, List<DialogOptionEntity>> _cachedEntities = HashMap();

  static cleanCached () {
    _cachedEntities = HashMap();
  }

  static addCache (SpeechNode node, List<DialogOptionEntity> list) {
    _cachedEntities[node] = list;
  }

  DialogOptionEntity(
      {required this.title, required this.onSelectProg, required this.props, required this.environment});

  String title;
  BaseNode onSelectProg;
  Environment environment;

  DialogOptionNodeProps props;

  bool wasSelected = false;
  bool isAvailable = true;

  static Future<List<DialogOptionEntity>> create(SpeechNode node,
      Future<EvalResult> Function(BaseNode) eval, Environment env) async {
    List<DialogOptionEntity> options = [];
    List<DialogOptionEntity>? cached = _cachedEntities[node];

    for (var i = 0; i < node.dialogOptions.length; i++) {
      final option = node.dialogOptions[i] as DialogOptionNode;

      final entity = DialogOptionEntity(
          title: (await eval(option.text)).value,
          onSelectProg: option.onSelectProg,
          environment: env,
          props: option.props);

      if (option.props.condition != null) {
        entity.isAvailable = (await eval(option.props.condition!)).value;
      }

      if (cached != null) {
        entity.wasSelected = cached[i].wasSelected;
      }

      options.add(entity);
    }

    addCache(node, options);

    return options;
  }
}
