import 'dart:convert';

import 'package:flutter_note/common/model/joke/juhe_joke/joke.dart';
import 'package:flutter_note/common/model/joke/juhe_joke/juhe_res.dart';
import 'package:flutter_note/common/model/joke/juhe_joke/result.dart';
import 'package:flutter_note/common/model/juhe/news.dart';
import 'package:flutter_note/common/model/juhe/res_juhe.dart';
import 'package:flutter_note/common/model/juhe/result.dart';

class JSON {
  factory JSON() => _instance;

  JSON._internal();

  static final JSON _instance = JSON._internal();

  ///map或string转model实体，使用后无需as T转换类型
  T fromJsonAs<T>(dynamic content) {
    var value;
    if (content is String) {
      value = json.decode(content);
    } else if (content is Map<String, dynamic>) {
      value = content;
    } else {
      throw const FormatException("content is not json format");
    }

    switch (T) {
      case JuheResponse<Result<Joke>>:
        return JuheResponse<Result<Joke>>.fromJson(value) as T;
      case Result<Joke>:
        return Result<Joke>.fromJson(value) as T;
      case Joke:
        return Joke.fromJson(value) as T;
      case ResJuhe<ResultJuhe<News>>:
        return ResJuhe<ResultJuhe<News>>.fromJson(value) as T;
      case ResultJuhe<News>:
        return ResultJuhe<News>.fromJson(value) as T;
      case News:
        return News.fromJson(value) as T;
      default:
        throw const FormatException("no model provided for content");
    }
    // return json;
  }

  ///map或string转model实体，使用后需用as T转换相应的对象类型
  dynamic fromJson(dynamic content, Type type) {
    var value;
    if (content is String) {
      //字符串需经过json解码为map格式
      value = json.decode(content);
      if (value is List) {
        return fromJson(value, type);
      }
    } else if (content is Map<String, dynamic>) {
      //map形式直接使用
      value = content;
    } else if (content is List) {
      //List则嵌套调用自身即可
      if (type == List) {
        throw const FormatException("type must be single model");
      }
      return content.map((e) => {fromJson(e, type)}).toList();
    } else {
      throw const FormatException("content is not json format");
    }

    switch (type) {
      case JuheResponse<Result<Joke>>:
        return JuheResponse<Result<Joke>>.fromJson(value);
      case Result<Joke>:
        return Result<Joke>.fromJson(value);
      case Joke:
        return Joke.fromJson(value);
      case ResJuhe<ResultJuhe<News>>:
        return ResJuhe<ResultJuhe<News>>.fromJson(value);
      case ResultJuhe<News>:
        return ResultJuhe<News>.fromJson(value);
      case News:
        return News.fromJson(value);
      default:
        throw const FormatException("no model provided for content");
    }
    // return json;
  }

  ///实体转map或string
  dynamic toJson(dynamic data, bool bejson) {
    var result = bejson ? '' : Map<String, dynamic>();
    if (data is List) {
      return data.map((e) => toJson(e, bejson)).toList();
    } else {
      switch (data.runtimeType) {
        case Joke:
          result = (data as Joke).toJson();
          break;
        case Result<Joke>:
          result = (data as Result<Joke>).toJson();
          break;
        case JuheResponse<Result<Joke>>:
          result = (data as JuheResponse<Result<Joke>>).toJson();
          break;
        case News:
          result = (data as News).toJson();
          break;
        case ResultJuhe<News>:
          result = (data as ResultJuhe<News>).toJson();
          break;
        case ResJuhe<ResultJuhe<News>>:
          result = (data as ResJuhe<ResJuhe<News>>).toJson();
          break;
        default:
          print("no model provided toJson");
      }
    }
    if (bejson) {
      result = json.encode(result);
    }
    return result;
  }
}
