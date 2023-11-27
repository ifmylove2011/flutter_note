import 'dart:io';

import 'package:flutter_note/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    if (Platform.isWindows || Platform.isLinux) {
      final docsDir = await getApplicationDocumentsDirectory();
      // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
      final store =
          await openStore(directory: p.join(docsDir.path, "databases", "note"));
      return ObjectBox._create(store);
    } else {
      final store = await openStore();
      return ObjectBox._create(store);
    }
  }
}
