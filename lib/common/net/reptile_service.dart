import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';

class ReptileService {
  static getMomoLocal() async {
    var res = await rootBundle.loadString("assets/data/momo.json");
    // print(res);
    List<Momo> result = JSON().fromJson(res.toString(), List<Momo>);
    return result;
  }
}
