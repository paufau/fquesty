// import 'package:just_audio_libwinmedia/just_audio_libwinmedia.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../cmp/ast/nodes/player/PlayerNode.dart';


class Player {
  PlayerNode node;

  AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  play (String assetPath, {bool loop = true}) async {
    if (isPlaying == true) {
      pause();
    }

    final asset = await rootBundle.load(assetPath);
    final dir = await getApplicationDocumentsDirectory();
    var file = File(dir.path + "/" + assetPath);
    await file.create(recursive: true);
    file.writeAsBytesSync(asset.buffer.asInt8List());

    _player = AudioPlayer();
    await _player.setFilePath(file.path);
    await _player.setLoopMode(loop ? LoopMode.all : LoopMode.off);
    isPlaying = true;

    await _player.setVolume(0);
    _player.play();
    await smoothTurnOnVolume(_player, 12, 0);
    return;
  }

  smoothTurnOnVolume(AudioPlayer p, int steps, int currentStep) async {
    final nextVolume = p.volume > 0 ? p.volume * 1.2 : 0.1;

    if (steps == currentStep || nextVolume > 1) {
      p.setVolume(1);
      return;
    }

    await Future.delayed(Duration(milliseconds: 75), () async {
      await p.setVolume(nextVolume);
    });

    return await smoothTurnOnVolume(p, steps, currentStep + 1);
  }

  smoothTurnOffVolume(AudioPlayer p, int steps, {required int currentStep}) async {
    if (steps == currentStep) {
      p.setVolume(0);
      return;
    }

    await Future.delayed(Duration(milliseconds: 75), () async {
      await p.setVolume(p.volume * 0.85);
    });

    return await smoothTurnOffVolume(p, steps, currentStep: currentStep + 1);
  }

  pause () async {
    isPlaying = false;
    final p = _player;
    final volume = p.volume;
    await smoothTurnOffVolume(p, 12, currentStep: 0);
    await p.setVolume(volume);
    return p.pause();
  }

  Player({required this.node});
}