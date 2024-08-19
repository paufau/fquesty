import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/state/GSContainerState.dart';
import 'package:fquest_engine/engine/scene/state/GSState.dart';
import 'package:fquest_engine/engine/scene/widgets/DialogOptionsWidget.dart';
import 'package:fquest_engine/engine/scene/widgets/surface/SurfacesContainerWidget.dart';

import 'widgets/CharacterNameWidget.dart';
import 'widgets/SpeechWidget.dart';

class GSWidget extends ConsumerStatefulWidget {
  GSWidget({Key? key, required this.sceneName}) : super(key: key);

  String sceneName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return GameSceneWidgetState();
  }
}

class GameSceneWidgetState extends ConsumerState<GSWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () => GSState.onPressNext(ref),
          child: AspectRatio(
            aspectRatio: 1920 / 1080,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ref.read(GSContainerState.computeSize.notifier).setConstraints(constraints);
                });

                final computeSize = ref.watch(GSContainerState.computeSize);

                return ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      SurfacesContainerWidget(),
                      Container(
                        margin: EdgeInsets.only(
                            left: computeSize(200.0),
                            right: computeSize(200.0),
                            bottom: computeSize(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    flex: 943,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CharacterNameWidget(
                                            computeSize: computeSize),
                                        SpeechWidget(computeSize: computeSize),
                                      ],
                                    )),
                                DialogOptionsWidget(computeSize: computeSize)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
