import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AssetSizeService {
  static Future<Size> getAssetImageSize (String path) async {
    final imageResource = await rootBundle.load(path);
    final imageUintBytes = imageResource.buffer
        .asUint8List(imageResource.offsetInBytes, imageResource.lengthInBytes);
    final decodedImage = await decodeImageFromList(imageUintBytes);

    return Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
  }
}