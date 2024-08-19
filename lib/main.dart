import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/state/GSState.dart';

import 'engine/scene/GSContainerWidget.dart';
import 'engine/scene/GSWidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    DesktopWindow.setMinWindowSize(Size(800, 600));
    // DesktopWindow.setFullScreen(true);
    // DesktopWindow.setFullScreen(false);
  }

  runApp(const MyApp());
}

class KeyboardHandlerWidget extends ConsumerWidget {
  const KeyboardHandlerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Focus(
      autofocus: true,
      onKey: (focusNode, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.space) || event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          GSState.onPressNext(ref);
        }

        return KeyEventResult.handled;
      },
      focusNode: FocusNode(),
      child: MaterialApp(
        title: 'Engine (alpha)',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0x00000000)),
        home: GSContainerWidget(),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        child: KeyboardHandlerWidget()
    );
  }
}
