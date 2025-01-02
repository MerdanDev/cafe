import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Uint8List decodeBase64Image(String base64String) {
  return base64Decode(base64String);
}

Future<String> saveImageToStorage(
  Uint8List imageData, {
  required String name,
}) async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/$name.png';
  final file = File(imagePath);
  await file.writeAsBytes(imageData);
  return imagePath;
}

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  return directory!.path;
}

Future<File> writeFileToStorage(String data, String fileName) async {
  final path = await _localPath;
  final file = File('$path/$fileName.json');
  return file.writeAsString(data);
}
