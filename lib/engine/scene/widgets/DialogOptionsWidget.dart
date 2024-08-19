import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../styles/ColorsScheme.dart';
import '../state/GSState.dart';
import 'components/DialogOptionItemWidget.dart';

class DialogOptionsWidget extends ConsumerWidget {
  DialogOptionsWidget({Key? key, required this.computeSize}) : super(key: key);

  double Function(double) computeSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speech = ref.watch(GSState.speech);

    if (speech != null && speech.dialogOptions.isNotEmpty) {
      return Expanded(
        flex: 557,
          child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: computeSize(180.0),
          ),
          child: Container(
              child: Wrap(
                runSpacing: computeSize(10.0),
                children: <Widget>[
                  for (var i = 0; i < speech.dialogOptions.length; i++)
                    DialogOptionItemWidget(
                        computeSize: computeSize,
                        option: speech.dialogOptions[i])
                ],
              ),
              decoration: BoxDecoration(
                  color: ColorsScheme.replicaAreaBackground,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: computeSize(20.0)),
              margin: EdgeInsets.only(left: computeSize(30.0)))));
    }

    return const SizedBox.shrink();
  }
}
