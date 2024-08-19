import 'package:fquest_engine/engine/services/player/models/Player.dart';

import '../../../cmp/ast/nodes/player/PlayerNode.dart';

class PlayerService {
  static Map<String, Player> players = {};

  static add (PlayerNode node) {
    final player = Player(node: node);
    players = {
      ...players,
      node.label: player,
    };
  }

  static Player? get (String label) {
    return players[label];
  }
}