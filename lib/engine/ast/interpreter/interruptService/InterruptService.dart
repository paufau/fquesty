import 'package:fquest_engine/cmp/ast/nodes/prog/ProgNode.dart';
import 'package:fquest_engine/engine/ast/interpreter/environment/Environment.dart';

class ProgEntity {
  ProgEntity({required this.progNode, required Environment this.progEnv});

  Environment progEnv;
  ProgNode progNode;
  int lastEvaluatedIndex = -1;
}

class ProgStack {
  List<ProgEntity> progs = [];

  push(ProgNode progNode, Environment progEnv) {
    progs.insert(0, ProgEntity(progNode: progNode, progEnv: progEnv));
  }

  pop() {
    progs.removeAt(0);
  }

  ProgEntity? getProgEntity() {
    return progs[0];
  }

  isEmpty() {
    return progs.isEmpty;
  }
}

class InterruptService {
  InterruptService();

  ProgStack progStack = ProgStack();

  int getAnchorIndex(String anchorLabel) {
    final prog = progStack.getProgEntity();
    int? index = prog?.progNode.anchors[anchorLabel];
    return index ?? -1;
  }

  void jumpToAnchor(String anchorLabel) {
    final progEntity = progStack.getProgEntity();

    if (progEntity != null) {
      final labelIndex = getAnchorIndex(anchorLabel);

      if (labelIndex != -1) {
        progEntity.lastEvaluatedIndex = labelIndex;
      } else {
        progStack.pop();
        jumpToAnchor(anchorLabel);
      }
    } else {
      print("LABEL NOT FOUND: " + anchorLabel);
    }
  }

  ProgEntity? getNextNode() {
    if (!progStack.isEmpty()) {
      final progEntity = progStack.getProgEntity();
      if (progEntity != null &&
          progEntity.progNode.prog.length - 1 ==
              progEntity.lastEvaluatedIndex) {
        progStack.pop();
        return getNextNode();
      }
      if (progEntity != null) {
        return progEntity;
      }
    }
    return null;
  }
}
