import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fun_adventure/cores/methods/retrieve_cached_image.dart';

Future<Uint8List> downloadAndStoreImage(String imageUrl) async {
  final cacheManager = DefaultCacheManager();
  await cacheManager.downloadFile(imageUrl);
  return await retrieveImageFromCache(imageUrl);
}
