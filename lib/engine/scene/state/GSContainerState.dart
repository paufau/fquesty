import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fquest_engine/engine/scene/entities/SurfaceEntiry.dart';

class _CurrentSceneId extends StateNotifier<String?> {
  _CurrentSceneId() : super(null);

  set(String name) {
    state = name;
  }
}

class _SurfacesNotifier extends StateNotifier<Map<String, SurfaceEntity>> {
  _SurfacesNotifier(Map<String, SurfaceEntity> state) : super(state);

  add(SurfaceEntity surfaceEntity) {
    state[surfaceEntity.label] = surfaceEntity;
  }

  remove(String label) {
    state.remove(label);
  }

  SurfaceEntity? get(String label) {
    return state[label];
  }
}

class _ScreenSizeNotifier extends StateNotifier<double Function(double)> {
  _ScreenSizeNotifier() : super((_) => 0);

  setConstraints(BoxConstraints constraints) {
    state = (double value) {
      return constraints.minHeight / 1080 * value;
    };
  }
}

class GSContainerState {
  static final computeSize =
      StateNotifierProvider<_ScreenSizeNotifier, double Function(double)>(
          (ref) {
    return _ScreenSizeNotifier();
  });

  static final surfaces =
      StateNotifierProvider<_SurfacesNotifier, Map<String, SurfaceEntity>>(
          (ref) {
    return _SurfacesNotifier({});
  });

  static final currentSceneName =
      StateNotifierProvider<_CurrentSceneId, String?>((ref) {
    return _CurrentSceneId();
  });
}
