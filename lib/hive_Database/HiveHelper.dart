// hive_helper.dart
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static final Box _box = Hive.box('myBox');

  // Save data
  static Future<void> saveData(String key, dynamic value) async {
    await _box.put(key, value);
  }

  // Retrieve data
  static dynamic getData(String key) {
    return _box.get(key);
  }

  // Example for a specific type like List
  static List<String>? getList(String key) {
    return _box.get(key)?.cast<String>();
  }

  // Example for a custom object
  // static MyModel? getMyModel(String key) {
  //   return _box.get(key) as MyModel?;
  // }

    // Store image file
  static Future<void> storeImage(String key, File imageFile) async {
    List<int> bytes = await imageFile.readAsBytes();
    await _box.put(key, bytes);
  }

  static Future<File?> getImage(String key) async {
  List<int>? bytes = _box.get(key);
  if (bytes != null) {
    try {
      String tempDir = (await getTemporaryDirectory()).path;
      String filePath = '$tempDir/$key';
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      print('Error retrieving image: $e');
      return null;
    }
  } else {
    print('Image bytes not found for key: $key');
    return null;
  }
}


    // Clear all data in the box
  static Future<void> clearAllData() async {
    await _box.clear();
  }

  // Clear data
  static Future<void> clearData(String key) async {
    await _box.delete(key);
  }

  void clearLogStatus() async {
  var box = await Hive.openBox('myBox');
  await box.delete('PIN_stored');
  //await box..delete('log_Status');
}
}
