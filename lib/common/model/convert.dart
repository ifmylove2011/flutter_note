import 'dart:convert';

import 'package:flutter_note/common/model/django/django.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/model/juhe/bulletin.dart';
import 'package:flutter_note/common/model/juhe/joke.dart';
import 'package:flutter_note/common/model/juhe/news.dart';
import 'package:flutter_note/common/model/juhe/res_juhe.dart';
import 'package:flutter_note/common/model/juhe/result.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';

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
      case const (Response<Result<Joke>>):
        return Response<Result<Joke>>.fromJson(value) as T;
      case const (Result<Joke>):
        return Result<Joke>.fromJson(value) as T;
      case Joke:
        return Joke.fromJson(value) as T;
      case const (Response<ResultPage<News>>):
        return Response<ResultPage<News>>.fromJson(value) as T;
      case const (ResultPage<News>):
        return ResultPage<News>.fromJson(value) as T;
      case News:
        return News.fromJson(value) as T;
      case const (Response<ResultL<Bulletin>>):
        return Response<ResultL<Bulletin>>.fromJson(value) as T;
      case const (ResultL<Bulletin>):
        return ResultL<Bulletin>.fromJson(value) as T;
      case Bulletin:
        return Bulletin.fromJson(value) as T;
      case Momo:
        return Momo.fromJson(value) as T;
      default:
        throw const FormatException("no model provided for content");
    }
    // return json;
  }

  ///map或string转model实体，使用后需用as T转换相应的对象类型
  dynamic fromJson(dynamic content, Type type) {
    var value;
    if (content is String) {
      print("content is String ,type=$type");
      //字符串需经过json解码为map格式
      value = json.decode(content);
      if (value is List) {
        return fromJson(value, type);
      }
    } else if (content is Map<String, dynamic>) {
      print("content is Map ,type=$type");
      //map形式直接使用
      value = content;
    } else if (content is List) {
      print("content is List ,type=$type");
      value = content;
    } else {
      throw const FormatException("content is not json format");
    }

    switch (type) {
      case const (Django<List<Note>>):
        return Django<List<Note>>.fromJson(value);
      case const (List<Note>):
        return (value as List).map<Note>((e) => fromJson(e, Note)).toList();
      case Note:
        return Note.fromJson(value);
      case const (Response<Result<Joke>>):
        return Response<Result<Joke>>.fromJson(value);
      case const (Result<Joke>):
        return Result<Joke>.fromJson(value);
      case const (List<Joke>):
        return (value as List).map<Joke>((e) => fromJson(e, Joke)).toList();
      case Joke:
        return Joke.fromJson(value);
      case const (Response<ResultPage<News>>):
        return Response<ResultPage<News>>.fromJson(value);
      case const (ResultPage<News>):
        return ResultPage<News>.fromJson(value);
      case const (List<News>):
        return (value as List).map<News>((e) => fromJson(e, News)).toList();
      case News:
        return News.fromJson(value);
      case const (Response<ResultL<Bulletin>>):
        return Response<ResultL<Bulletin>>.fromJson(value);
      case const (ResultL<Bulletin>):
        return ResultL<Bulletin>.fromJson(value);
      case const (List<Bulletin>):
        return (value as List)
            .map<Bulletin>((e) => fromJson(e, Bulletin))
            .toList();
      case Bulletin:
        return Bulletin.fromJson(value);
      case Momo:
        return Momo.fromJson(value);
      case const (List<Momo>):
        return (value as List).map<Momo>((e) => fromJson(e, Momo)).toList();
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
        case const (Result<Joke>):
          result = (data as Result<Joke>).toJson();
          break;
        case const (Response<Result<Joke>>):
          result = (data as Response<Result<Joke>>).toJson();
          break;
        case News:
          result = (data as News).toJson();
          break;
        case const (ResultPage<News>):
          result = (data as ResultPage<News>).toJson();
          break;
        case const (Response<ResultPage<News>>):
          result = (data as Response<Response<News>>).toJson();
          break;
        case Bulletin:
          result = (data as Bulletin).toJson();
          break;
        case const (ResultL<Bulletin>):
          result = (data as ResultL<Bulletin>).toJson();
          break;
        case const (Response<ResultL<Bulletin>>):
          result = (data as Response<ResultL<Bulletin>>).toJson();
          break;
        case Momo:
          result = (data as Momo).toJson();
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
