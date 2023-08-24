import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/juhe/bulletin.dart';
import 'package:flutter_note/common/model/juhe/result.dart';
import 'package:flutter_note/common/net/dio_request.dart';
import 'package:flutter_note/common/model/juhe/res_juhe.dart';
import 'package:flutter_note/common/model/juhe/result.dart';

class JuheService {
  static const String bulletinKey = "2ec96a8869a74b64cf6bc00f9d6b8414";

  static getBulletins() async {
    var res = await JuheHolder.get()
        .dio
        .get('/fapigx/bulletin/query', queryParameters: {"key": bulletinKey});
    print(res.toString());
    Response<ResultL<Bulletin>> result =
        JSON().fromJsonAs<Response<ResultL<Bulletin>>>(res.toString());
    return result.result!.list;
  }
}
