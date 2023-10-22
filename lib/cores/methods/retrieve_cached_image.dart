import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<Uint8List> retrieveImageFromCache(String imageUrl) async {
  final cacheManager = DefaultCacheManager();
  final File file = await cacheManager.getSingleFile(imageUrl);
  return file.readAsBytesSync();
}
