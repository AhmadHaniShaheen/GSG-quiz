import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:api_qize/service/share_image.dart';

Future<void> capturePng(BuildContext context, GlobalKey globalKey) async {
  RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  // if (boundary.debugNeedsPaint) {
  // if (kDebugMode) {
  //   print("Waiting for boundary to be painted.");
  // }
  // await Future.delayed(const Duration(milliseconds: 20));
  ui.Image image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List? pngBytes = byteData!.buffer.asUint8List();

  if (kDebugMode) {
    print(pngBytes);
  }

  // ignore: use_build_context_synchronously
  onShareXFileFromAssets(context, byteData);
  // }
}
