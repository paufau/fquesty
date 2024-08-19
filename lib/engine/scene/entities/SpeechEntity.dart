import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/speech/SpeechNode.dart';
import 'package:fquest_engine/engine/ast/interpreter/environment/Environment.dart';
import 'package:fquest_engine/engine/scene/entities/CharacterEntity.dart';
import 'package:fquest_engine/engine/scene/entities/DialogOptionEntity.dart';

import '../../ast/interpreter/models/EvalResult.dart';

class SpeechEntity {
  late CharacterEntity character;
  late String text;

  List<DialogOptionEntity> dialogOptions;

  SpeechEntity(
      {required this.character,
      required this.text,
      this.dialogOptions = const []});

  static Future<SpeechEntity> create(
      SpeechNode node, Future<EvalResult> Function(BaseNode) eval, Environment environment) async {
    return SpeechEntity(
        character: (await eval(node.character)).value,
        text: (await eval(node.text)).value,
        dialogOptions: await DialogOptionEntity.create(node, eval, environment));
  }
}
