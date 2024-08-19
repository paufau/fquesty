import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/state/GSContainerState.dart';
import 'package:fquest_engine/engine/scene/state/GSGlobalState.dart';
import 'package:fquest_engine/engine/story/Story.dart';

import 'GSWidget.dart';

class GSContainerWidget extends ConsumerStatefulWidget {
  const GSContainerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return GSContainerWidgetState();
  }
}

class GSContainerWidgetState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(GSGlobalState.interpreter.notifier).init(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    final currentSceneName = ref.watch(GSContainerState.currentSceneName);
    final story = ref.watch(Story.prog);

    if (story != null && currentSceneName != null) {
      return GSWidget(sceneName: currentSceneName, key: Key(currentSceneName));
    }
    return GestureDetector(
      onTap: () {
        ref.read(GSGlobalState.interpreter.notifier).state?.evalNext();
      },
      child: Container(color: Colors.amberAccent,),
    );
  }
}
