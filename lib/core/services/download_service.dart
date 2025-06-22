import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;

@lazySingleton
class DownloadService {
  final Dio _dio = Dio();

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      // Try storage permission first
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) {
        return true;
      }

      // If storage permission is denied, try manage external storage
      final manageStatus = await Permission.manageExternalStorage.request();
      return manageStatus.isGranted;
    }
    // iOS doesn't require explicit permission for saving to its sandboxed directories.
    return true;
  }

  Future<void> downloadAndOpenFile(
    String url,
    String fileName, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    final hasPermission = await requestPermissions();
    if (!hasPermission) {
      throw 'Storage permission denied';
    }

    final dir = await getExternalStoragePublicDirectory('Download');
    final savePath = '${dir?.path}/$fileName';

    await _dio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
    );

    final openResult = await OpenFile.open(savePath);

    if (openResult.type != ResultType.done) {
      throw 'Could not open the downloaded file: ${openResult.message}';
    }
  }

  Future<void> saveAndOpenAssetFromBundle(
      String assetPath, String fileName) async {
    final hasPermission = await requestPermissions();
    if (!hasPermission) {
      throw 'Storage permission denied';
    }

    // Get the byte data of the asset
    final byteData = await rootBundle.load(assetPath);
    final buffer = byteData.buffer;

    // Get the public downloads directory
    final dir = await getExternalStoragePublicDirectory('Download');
    final filePath = '${dir?.path}/$fileName';

    // Write the file
    await File(filePath).writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    // Open the file
    final openResult = await OpenFile.open(filePath);
    if (openResult.type != ResultType.done) {
      throw 'Could not open the downloaded file: ${openResult.message}';
    }
  }
}

// Helper for Android 13+ as getExternalStoragePublicDirectory is less reliable
Future<Directory?> getExternalStoragePublicDirectory(String type) async {
  if (Platform.isAndroid) {
    final downloadsDir = Directory('/storage/emulated/0/Download');
    if (await downloadsDir.exists()) {
      return downloadsDir;
    }
  }
  return getApplicationDocumentsDirectory(); // Fallback
}
