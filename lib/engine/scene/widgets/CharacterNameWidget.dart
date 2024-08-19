import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../styles/ColorsScheme.dart';
import '../state/GSState.dart';

class CharacterNameWidget extends ConsumerWidget {
  CharacterNameWidget({Key? key, required this.computeSize}) : super(key: key);

  double Function(double) computeSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speech = ref.watch(GSState.speech);

    if (speech != null && speech.character.name != null) {
      return Container(
        decoration: BoxDecoration(
            color: ColorsScheme.characterNameBackground,
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(
            horizontal: computeSize(30.0), vertical: computeSize(20.0)),
        margin: EdgeInsets.only(bottom: computeSize(10.0)),
        child: Text(
          speech.character.name!,
          style: TextStyle(
            fontSize: computeSize(24.0),
            height: 30 / 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: ColorsScheme.replicaText,
          ),
        ),
      );
    }

    return SizedBox.shrink();
  }
}
