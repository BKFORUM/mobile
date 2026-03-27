import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<File> testCompressAndGetFile(File file, String prefix) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String appPath = appDir.path;
  final String fileName = path.basename(file.path);
  final String newPath = '$appPath/$prefix$fileName';

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    newPath,
    quality: 50,
  );

  return File(result!.path);
}