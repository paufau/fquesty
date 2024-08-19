import 'package:fquest_engine/cmp/AssetPath.dart';
import 'package:fquest_engine/cmp/ast/nodes/anchor/AnchorNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/animation/AnimationNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/assign/AssignNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/base/BaseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/binary/BinaryNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/bool/BoolNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/call/CallNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/character/CharacterNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/clean/CleanNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/dialog/option/DialogOptionNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/dialog/option/props/DialogOptionNodeProps.dart';
import 'package:fquest_engine/cmp/ast/nodes/func/FuncNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/hide/HideNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/hide/props/HideNodeProps.dart';
import 'package:fquest_engine/cmp/ast/nodes/if/IfNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/jump/JumpNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/num/NumNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/pause/PauseNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/play/PlayNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/player/PlayerNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/prog/ProgNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/return/ReturnNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/scene/SceneNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/show/ShowNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/show/props/ShowNodeProps.dart';
import 'package:fquest_engine/cmp/ast/nodes/speech/SpeechNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/sprite/SpriteNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/str/StrNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/surface/SurfaceNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/var/VarNode.dart';
import 'package:fquest_engine/cmp/ast/nodes/wait/WaitNode.dart';
import 'package:fquest_engine/cmp/parsers/base/BaseParser.dart';
import 'package:fquest_engine/cmp/streams/Keywords.dart';
import 'package:fquest_engine/cmp/streams/Token.dart';
import 'package:fquest_engine/cmp/streams/TokenStream.dart';
import 'package:fquest_engine/engine/character/Position.dart';

import 'ast/nodes/animate/AnimateNode.dart';

class AstParser extends BaseParser {
  AstParser({required TokenStream tokenStream})
      : super(tokenStream: tokenStream) {}

  Map<String, int> findProgAnchors(List<BaseNode> prog) {
    Map<String, int> anchors = {};

    for (var i = 0; i < prog.length; i++) {
      if (prog[i].type == ENodeType.ANCHOR) {
        anchors[(prog[i] as AnchorNode).label] = i;
      }
    }

    return anchors;
  }

  Future<BaseNode> parseProg() async {
    final prog =
        await helper.delimited(start: '{', stop: '}', parser: parseExpression);

    return ProgNode(prog: prog, anchors: findProgAnchors(prog));
  }

  Future<BaseNode> parseIf() async {
    helper.skipKeyword(KeywordsMap[EKeyword.IF]);
    final condNode = await parseExpression();
    final thenNode = await parseExpression();
    final ifNode = IfNode(condNode: condNode, thenNode: thenNode);

    if (helper.isKeyword(KeywordsMap[EKeyword.ELSE]) != null) {
      tokenStream.next();
      ifNode.elseNode = await parseExpression();
    }

    return ifNode;
  }

  Future<BaseNode> parseBool() async {
    return BoolNode(
        value: tokenStream.next()!.value == KeywordsMap[EKeyword.TRUE]);
  }

  Future<BaseNode> parseFunc() async {
    final name = helper.parseVarName();
    return AssignNode(
        leftNode: VarNode(value: name),
        rightNode: FuncNode(
          vars: await helper.delimited(
              start: '(',
              stop: ')',
              separator: ',',
              parser: () async => helper.parseVarName()),
          bodyNode: await parseExpression(),
        ));
  }

  Future<BaseNode> parseCall(BaseNode func) async {
    return CallNode(
        func: func,
        args: await helper.delimited(
            start: '(', stop: ')', separator: ',', parser: parseExpression));
  }

  Future<BaseNode> maybeCall(Future<BaseNode> Function() expr) async {
    final node = await expr();
    if (helper.isPunc('(') != null && node.type == ENodeType.VAR) {
      return await parseCall(node);
    }
    return node;
  }

  Future<BaseNode> parseReturn() async {
    return ReturnNode(returnNode: await parseExpression());
  }

  Future<SceneNode> parseScene() async {
    final name = helper.parseVarName();
    return SceneNode(prog: await parseProg(), name: name);
  }

  Future<Map<String, BaseNode>> parseProp() async {
    Map<String, BaseNode> res = {};
    final name = tokenStream.next()!.value;
    helper.skipPunc(':');

    final value = await parseExpression();

    res[name] = value;
    return res;
  }

  Future<Map<String, BaseNode>> parseProps() async {
    Map<String, BaseNode> res = {};

    if (helper.isPunc(':') != null) {
      helper.skipPunc(':');
      final props = await helper.delimited(
          start: '(', stop: ')', separator: ',', parser: parseProp);
      for (final p in props) {
        res.addAll(p);
      }
    }

    return res;
  }

  Future<BaseNode> parseCharacter() async {
    final label = helper.parseVarName();
    final props = await parseProps();

    return CharacterNode(label: label, name: props['name'], sprite: props['sprite']);
  }

  Future<List<DialogOptionNode>> parseDialogOptions() async {
    List<DialogOptionNode> options = [];
    while (tokenStream.peek()?.value == '-') {
      helper.skipOperation('-');
      final text = await parseAtom();

      final props = DialogOptionNodeProps();

      final parsedProps = await parseProps();
      props.onceSelectable = parsedProps['onceSelectable'] != null
          ? (parsedProps['onceSelectable'] as BoolNode).value
          : null;
      props.condition = parsedProps['condition'];

      final onSelectProg = await parseAtom();
      options.add(DialogOptionNode(
          text: text, onSelectProg: onSelectProg, props: props));
    }
    return options;
  }

  Future<SpeechNode> parseSpeech(Token characterLabelToken) async {
    final characterNode = VarNode(value: characterLabelToken.value);
    final text = await parseAtom();
    final dialogOptions = await parseDialogOptions();
    return SpeechNode(character: characterNode, text: text, dialogOptions: dialogOptions);
  }

  Future<AnchorNode> parseAnchor() async {
    helper.skipKeyword(KeywordsMap[EKeyword.ANCHOR]);
    return AnchorNode(label: helper.parseVarName());
  }

  Future<JumpNode> parseJump() async {
    helper.skipKeyword(KeywordsMap[EKeyword.JUMP]);
    return JumpNode(label: helper.parseVarName());
  }

  T? getPropValue<T>(BaseNode? node) {
    return node != null ? node as T : null;
  }

  Future<HideNode> parseHide() async {
    helper.skipKeyword(KeywordsMap[EKeyword.HIDE]);
    final sprite = await parseAtom();

    final hideNodeProps = HideNodeProps();

    final props = await parseProps();

    final animation = getPropValue<BaseNode>(props['animation']);
    if (animation != null) {
      hideNodeProps.animation = animation;
    }

    return HideNode(sprite: sprite, props: hideNodeProps);
  }

  Future<ShowNode> parseShow() async {
    helper.skipKeyword(KeywordsMap[EKeyword.SHOW]);
    final surface = await parseAtom();
    final sprite = await parseAtom();
    final showNodeProps = ShowNodeProps();

    final props = await parseProps();

    showNodeProps.position = Position(
      left: getPropValue<NumNode>(props['left'])?.value,
      right: getPropValue<NumNode>(props['right'])?.value,
      top: getPropValue<NumNode>(props['top'])?.value,
      bottom: getPropValue<NumNode>(props['bottom'])?.value,
    );

    final animationNode = getPropValue<BaseNode>(props['animation']);
    if (animationNode != null) {
      showNodeProps.animation = animationNode;
    }

    showNodeProps.scale = getPropValue<BaseNode>(props['scale']);
    showNodeProps.opacity = getPropValue<BaseNode>(props['opacity']);
    showNodeProps.slideX = getPropValue<BaseNode>(props['slideX']);
    showNodeProps.slideY = getPropValue<BaseNode>(props['slideY']);

    return ShowNode(surface: surface, sprite: sprite, props: showNodeProps);
  }

  Future<PlayerNode> parsePlayer() async {
    helper.skipKeyword(KeywordsMap[EKeyword.PLAYER]);
    final label = helper.parseVarName();
    return PlayerNode(label: label);
  }

  Future<PlayNode> parsePlay() async {
    helper.skipKeyword(KeywordsMap[EKeyword.PLAY]);
    final playerLabel = helper.parseVarName();
    final assetPathNode = await parseAtom();
    String assetPath = AssetPath.SOUND + (assetPathNode as StrNode).value;
    return PlayNode(assetPath: assetPath, playerLabel: playerLabel);
  }

  Future<PauseNode> parsePause() async {
    helper.skipKeyword(KeywordsMap[EKeyword.PAUSE]);
    final playerLabel = helper.parseVarName();
    return PauseNode(playerLabel: playerLabel);
  }

  Future<AnimationNode> parseAnimation() async {
    helper.skipKeyword(KeywordsMap[EKeyword.ANIMATION]);
    final animationName = helper.parseVarName();

    Map<String, BaseNode> props = await parseProps();

    return AnimationNode(animationName: animationName, props: props);
  }

  Future<SurfaceNode> parseSurface() async {
    helper.skipKeyword(KeywordsMap[EKeyword.SURFACE]);
    final label = helper.parseVarName();
    final props = await parseProps();
    final zIndex = getPropValue<NumNode>(props['zIndex'])!.value;
    final singleSprite = getPropValue<BoolNode?>(props['singleSprite']);
    return SurfaceNode(label: label, zIndex: zIndex, singleSprite: singleSprite?.value);
  }

  Future<SpriteNode> parseSprite() async {
    helper.skipKeyword(KeywordsMap[EKeyword.SPRITE]);
    final label = helper.parseVarName();
    final props = await parseProps();

    StrNode? assetPath = getPropValue<StrNode>(props['assetPath']);
    if (assetPath != null) {
      assetPath.value = AssetPath.SPRITE + assetPath.value;
      topLevelAssets.add(assetPath.value);
    } else {
      tokenStream.error('Expecting assetPath in sprite');
    }
    assetPath as StrNode;

    return SpriteNode(assetPath: assetPath, label: label);
  }

  Future<CleanNode> parseClean() async {
    helper.skipKeyword(KeywordsMap[EKeyword.CLEAN]);
    final surface = await parseAtom();
    return CleanNode(surface: surface);
  }

  Future<AnimateNode> parseAnimate() async {
    helper.skipKeyword(KeywordsMap[EKeyword.ANIMATE]);
    final sprite = await parseAtom();
    final animation = await parseAtom();
    return AnimateNode(sprite: sprite, animation: animation);
  }

  Future<BaseNode> parseAtom() async {
    final Map<EKeyword, Future<BaseNode> Function()> keywordParsers = {
      EKeyword.ANIMATE: parseAnimate,
      EKeyword.CLEAN: parseClean,
      EKeyword.SPRITE: parseSprite,
      EKeyword.SURFACE: parseSurface,
      EKeyword.ANIMATION: parseAnimation,
      EKeyword.PAUSE: parsePause,
      EKeyword.PLAYER: parsePlayer,
      EKeyword.PLAY: parsePlay,
      EKeyword.JUMP: parseJump,
      EKeyword.ANCHOR: parseAnchor,
      EKeyword.IF: parseIf,
      EKeyword.TRUE: parseBool,
      EKeyword.FALSE: parseBool,
      EKeyword.SHOW: parseShow,
      EKeyword.HIDE: parseHide,
    };

    return await maybeCall(() async {
      if (helper.isPunc('(') != null) {
        tokenStream.next();
        final node = await parseExpression();
        helper.skipPunc(')');
        return node;
      }
      if (helper.isPunc('{') != null) {
        return await parseProg();
      }

      for (var keyword in keywordParsers.keys) {
        if (helper.isKeyword(KeywordsMap[keyword]) != null) {
          return await keywordParsers[keyword]!();
        }
      }

      if (helper.isKeyword(KeywordsMap[EKeyword.FUNC]) != null) {
        tokenStream.next();
        return await parseFunc();
      }
      if (helper.isKeyword(KeywordsMap[EKeyword.RETURN]) != null) {
        tokenStream.next();
        return await parseReturn();
      }
      if (helper.isKeyword(KeywordsMap[EKeyword.SCENE]) != null) {
        tokenStream.next();
        return await parseScene();
      }
      if (helper.isKeyword(KeywordsMap[EKeyword.WAIT]) != null) {
        tokenStream.next();
        return WaitNode();
      }
      if (helper.isKeyword(KeywordsMap[EKeyword.CHARACTER]) != null) {
        tokenStream.next();
        return await parseCharacter();
      }

      final token = tokenStream.next()!;
      final nextToken = tokenStream.peek();

      if (nextToken != null &&
          token.type == ETokenType.VAR &&
          nextToken.type == ETokenType.STR) {
        return await parseSpeech(token);
      }

      if (token.type == ETokenType.VAR) {
        return VarNode(value: token.value);
      }
      if (token.type == ETokenType.NUM) {
        return NumNode(value: token.value);
      }
      if (token.type == ETokenType.STR) {
        return StrNode(value: token.value);
      }

      if (token.type == ETokenType.OP && token.value == '-' && nextToken != null && nextToken.type == ETokenType.NUM) {
        tokenStream.next();
        return NumNode(value: -nextToken.value);
      }

      tokenStream.error('Unexpected $token');
      return ProgNode<BaseNode>(prog: [], anchors: {});
    });
  }

  final POWER = {
    "=": 1,
    "||": 2,
    "&&": 3,
    "<": 7,
    ">": 7,
    "<=": 7,
    ">=": 7,
    "==": 7,
    "!=": 7,
    "+": 10,
    "-": 10,
    "*": 20,
    "/": 20,
    "%": 20,
  };

  Future<BaseNode> maybeBinary(BaseNode left, int leftPower) async {
    final operationToken = helper.isOperation(null);
    if (operationToken != null) {
      int rightPower = POWER[operationToken.value]!;
      if (rightPower > leftPower) {
        tokenStream.next();
        if (operationToken.value == '=') {
          return await maybeBinary(
              AssignNode(
                  leftNode: left,
                  rightNode: await maybeBinary(await parseAtom(), rightPower)),
              leftPower);
        }
        return await maybeBinary(
            BinaryNode(
                operator: operationToken.value,
                leftNode: left,
                rightNode: await maybeBinary(await parseAtom(), rightPower)),
            leftPower);
      }
    }
    return left;
  }

  Future<BaseNode> parseExpression() async {
    return maybeCall(() async {
      return await maybeBinary(await parseAtom(), 0);
    });
  }

  List<String> topLevelAssets = [];

  Future<ProgNode> parseTopLevel() async {
    List<BaseNode> prog = [];

    while (!tokenStream.isEmpty()) {
      prog.add(await parseExpression());
      if (!tokenStream.isEmpty() && helper.isPunc(';') != null) {
        helper.skipPunc(';');
      }
    }

    return ProgNode(
        prog: prog, anchors: findProgAnchors(prog), usedAssets: topLevelAssets);
  }
}
