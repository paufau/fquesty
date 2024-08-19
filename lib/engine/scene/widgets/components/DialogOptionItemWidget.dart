import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/entities/DialogOptionEntity.dart';

import '../../../components/OnHover.dart';
import '../../../styles/ColorsScheme.dart';
import '../../state/GSState.dart';

class DialogOptionItemWidget extends ConsumerWidget {
  DialogOptionItemWidget(
      {Key? key, required this.computeSize, required this.option})
      : super(key: key);

  double Function(double) computeSize;
  DialogOptionEntity option;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if ((option.props.onceSelectable != null && option.props.onceSelectable == true && option.wasSelected == true) || !option.isAvailable) {
      return SizedBox.shrink();
    }

    return Container(
        child: GestureDetector(
      onTap: () {
        GSState.onSelectDialogOption(context, ref, option);
      },
      child: OnHover(
        builder: (isHovered) => Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 170),
                  decoration: BoxDecoration(
                    color:
                        isHovered ? ColorsScheme.characterNameBackground : null,
                  )),
              left: 0,
              right: 0,
              top: computeSize(-10.0),
              bottom: computeSize(-10.0),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 170),
                    width: computeSize(16.0),
                    height: computeSize(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(computeSize(8.0)),
                      border: Border.all(
                          color: ColorsScheme.white, width: computeSize(3.0)),
                      color: isHovered ? null : ColorsScheme.white,
                    ),
                    margin: EdgeInsets.only(right: computeSize(12)),
                  ),
                  Expanded(child:                   Text(
                    option.title,
                    style: TextStyle(
                      fontSize: computeSize(20.0),
                      height: 1.3,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: ColorsScheme.replicaText,
                    ),
                  )
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: computeSize(32)),
              constraints: BoxConstraints(
                  minHeight: computeSize(40), minWidth: double.maxFinite),
            )
          ],
        ),
      ),
    ));
  }
}
