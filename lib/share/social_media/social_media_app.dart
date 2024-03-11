import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class SocialMediaShareApp extends StatefulWidget {

  const SocialMediaShareApp({
    required this.cardImgUri,
    required this.message,
    super.key
  });

  final String cardImgUri;
  final String message;
  
  @override
  State<SocialMediaShareApp> createState() => _SocialMediaShareAppState();
}

class _SocialMediaShareAppState extends State<SocialMediaShareApp> {
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    copyAssets();
  }

  Future<void> copyAssets() async {
    imagePath = await copyImage();
  }



  Future<String> copyImage() async {
    final tempDir = await getTemporaryDirectory();
    final String uuid = const Uuid().v4();
    ByteData bytes = await NetworkAssetBundle(Uri.parse(widget.cardImgUri)).load(widget.cardImgUri);
    final assetPath = '${tempDir.path}/$uuid.jpg';
    final file = await File(assetPath).create();
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file.path;
  }

  @override
  Widget build(BuildContext context) {

    return Material(child: ElevatedButton(
                        child: SizedBox(height: 48, child: Row(children: [
                          Icon(Icons.ios_share),
                          Text('Share')],)),
                        onPressed: () async {
                          Share.shareXFiles([XFile(imagePath)],text: widget.message);
                          print(imagePath);
                        },
                      ));
  }
}