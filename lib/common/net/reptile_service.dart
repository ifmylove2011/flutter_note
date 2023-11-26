import 'dart:convert';

import 'package:flutter_note/common/model/reptile/mei_ying.dart';
import 'package:html/dom.dart';

import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';
import 'package:flutter_note/objectbox.g.dart';
import 'package:web_scraper/web_scraper.dart';

import '../../main.dart';
import '../model/reptile/mei_ying_detail.dart';
import '../model/reptile/momo_detail.dart';

class ReptileService {
  static ReptileService? _instance;
  final momoBox = objectBox.store.box<Momo>();
  final momoDetailBox = objectBox.store.box<MomoDetail>();
  final meiyingBox = objectBox.store.box<MeiYing>();
  final meiyingDetailBox = objectBox.store.box<MeiYingDetail>();

  factory ReptileService() {
    _instance ??= ReptileService._internal();
    return _instance!;
  }

  ReptileService._internal();

  getMomo(int page) async {
    List<Momo> momos = await getMomoDB(page);
    print("db momo.size=${momos.length}");
    if (momos.isEmpty) {
      String? res = await requestMomoPost(page);
      momos = JSON().fromJson(res, List<Momo>);
      // print(momos);
      momos.sort((a, b) => a.dataPid!.compareTo(b.dataPid!));
      momoBox.putManyAsync(momos);
    }
    return momos;
  }

  getMomoDetail(int detailId, int page) async {
    List<MomoDetail> momoDetails = await getMomoDetailDB(detailId, page);
    print("db momoDetail.size=${momoDetails.length}");
    if (momoDetails.isEmpty) {
      String? res = await requestMomoDetail(detailId, page);
      momoDetails = JSON().fromJson(res, List<MomoDetail>);
      // momoDetails.sort((a, b) => b.id!.compareTo(a.id!));
      momoDetailBox.putManyAsync(momoDetails);
    }
    return momoDetails;
  }

  getMeiying(int page) async {
    List<MeiYing> meiyings = await getMeiYingDB(page);
    print("db meiying.size=${meiyings.length}");
    if (meiyings.isEmpty) {
      String? res = await requestMeiyingPost(page);
      meiyings = JSON().fromJson(res, List<MeiYing>);
      // print(momos);
      // momos.sort((a, b) => a.id!.compareTo(b.id!));
      meiyingBox.putManyAsync(meiyings);
    }
    return meiyings;
  }

  getMeiYingDetail(int detailId) async {
    List<MeiYingDetail> meiyingDetails = await getMeiYingDetailDB(detailId);
    print("db meiyingDetail.size=${meiyingDetails.length}");
    if (meiyingDetails.isEmpty) {
      String? res = await requestMeiyingDetail(detailId);
      meiyingDetails = JSON().fromJson(res, List<MeiYingDetail>);
      // momoDetails.sort((a, b) => b.id!.compareTo(a.id!));
      meiyingDetailBox.putManyAsync(meiyingDetails);
    }
    return meiyingDetails;
  }

  Future<String?> requestMomoPost(int page) async {
    WebScraper webScraperMomo = WebScraper();
    String dest = 'https://www.momotk4.es/page/$page';
    print(dest);
    bool called = await webScraperMomo.loadFullURL(dest);
    if (called) {
      print("scrapying ... loading ... $page");
      List<Map<String, dynamic>> momos = [];
      List<Element> articles = webScraperMomo.selects('article');
      for (var article in articles) {
        Map<String, dynamic> momo = {};
        momo['title'] = article.querySelector('h2')!.text;
        momo['detail_url'] = article.querySelector('a')!.attributes['href'];
        momo['post_url'] =
            article.querySelector('a img')!.attributes['data-src'];
        momo['data-pid'] = int.parse(
            article.querySelector('footer a')!.attributes['data-pid']!);
        momo['desc_num'] = article.querySelector('a div')!.text;
        momo['page'] = page;
        momos.add(momo);
      }
      String jsonS = json.encode(momos);
      return jsonS;
    } else {
      return null;
    }
  }

  Future<String?> requestMomoDetail(int detailId, int page) async {
    WebScraper webScraperMomo = WebScraper();
    bool called = await webScraperMomo.loadFullURL(
        'https://www.momotk4.es/$detailId.html/nggallery/page/$page');
    if (called) {
      print("scrapying ... loading ... detail ... $page");
      List<Map<String, dynamic>> details = [];
      List<Element> thumbnails =
          webScraperMomo.selects('div.ngg-gallery-thumbnail a');
      List<Element> pageNumTags =
          webScraperMomo.selects('div.ngg-navigation > a.page-numbers')!;
      int pageNum = int.parse(
          pageNumTags[pageNumTags.length - 1].attributes['data-pageid']!);
      for (var thumbnail in thumbnails) {
        Map<String, dynamic> detail = {};
        detail['id'] = int.parse(thumbnail.attributes['data-image-id']!);
        detail['title'] = thumbnail.attributes['data-title'];
        detail['img_url'] = thumbnail.attributes['href'];
        detail['detail_id'] = detailId;
        detail['page'] = page;
        detail['page_num'] = pageNum;
        details.add(detail);
      }
      String jsonS = json.encode(details);
      return jsonS;
    } else {
      return null;
    }
  }

  Future<String?> requestMeiyingPost(int page) async {
    WebScraper webScraperMomo = WebScraper();
    String dest =
        'https://myhl5.uno/%e6%9c%80%e6%96%b0%e5%8f%91%e5%b8%83/page/$page';
    print(dest);
    bool called = await webScraperMomo.loadFullURL(dest);
    if (called) {
      print("scrapying ... loading ... $page");
      List<Map<String, dynamic>> meiyings = [];
      List<Element> posts = webScraperMomo.selects('div.post.grid.grid-zz');
      for (var post in posts) {
        Map<String, dynamic> meiying = {};
        meiying['id'] = int.parse(post.attributes['data-id']!);
        meiying['title'] = post.querySelector('div.img a')!.attributes['title'];
        meiying['detail_url'] =
            post.querySelector('div.img a')!.attributes['href'];
        meiying['post_url'] =
            post.querySelector('div.img a img')!.attributes['data-src'];
        meiying['desc_num'] = post.querySelector('div.img a div.num')!.text;
        meiying['author'] = post.querySelector('div.grid-author a span')!.text;
        meiying['page'] = 1;
        meiyings.add(meiying);
      }
      String jsonS = json.encode(meiyings);
      return jsonS;
    } else {
      return null;
    }
  }

  Future<String?> requestMeiyingDetail(int detailId) async {
    WebScraper webScraperMomo = WebScraper();
    bool called =
        await webScraperMomo.loadFullURL('https://myhl5.uno/$detailId.html');
    if (called) {
      print("scrapying ... loading ... detail ... ");
      List<Map<String, dynamic>> details = [];
      List<Element> thumbnails =
          webScraperMomo.selects('div.gallery-item.gallery-fancy-item a');
      for (var thumbnail in thumbnails) {
        Map<String, dynamic> detail = {};
        detail['img_url'] = thumbnail.attributes['href'];
        detail['detail_id'] = detailId;
        details.add(detail);
      }
      String jsonS = json.encode(details);
      return jsonS;
    } else {
      return null;
    }
  }

  Future<List<Momo>> getMomoDB(int page) async {
    // if (momoBox.isEmpty()) {
    //   return List.empty();
    // }
    Query<Momo> query = momoBox
        .query(Momo_.page.equals(page))
        .order(Momo_.dataPid, flags: Order.descending)
        .build();
    List<Momo> momos = await query.findAsync();
    return momos;
  }

  Future<List<MomoDetail>> getMomoDetailDBAll(int detailId) async {
    Query<MomoDetail> query = momoDetailBox
        .query(MomoDetail_.detailId.equals(detailId))
        .order(MomoDetail_.id, flags: Order.descending)
        .build();
    List<MomoDetail> momos = await query.findAsync();
    return momos;
  }

  Future<List<MomoDetail>> getMomoDetailDB(int detailId, int page) async {
    // if (momoDetailBox.isEmpty()) {
    //   return List.empty();
    // }
    Query<MomoDetail> query = momoDetailBox
        .query(MomoDetail_.detailId.equals(detailId) &
            MomoDetail_.page.equals(page))
        .order(MomoDetail_.id, flags: Order.descending)
        .build();
    List<MomoDetail> momos = await query.findAsync();
    return momos;
  }

  Future<List<MeiYing>> getMeiYingDB(int page) async {
    // if (MeiYing.isEmpty()) {
    //   return List.empty();
    // }
    Query<MeiYing> query = meiyingBox
        .query(MeiYing_.page.equals(page))
        .order(MeiYing_.id, flags: Order.descending)
        .build();
    List<MeiYing> meiyings = await query.findAsync();
    return meiyings;
  }

  Future<List<MeiYingDetail>> getMeiYingDetailDB(int detailId) async {
    // if (meiyingDetailBox.isEmpty()) {
    //   return List.empty();
    // }
    Query<MeiYingDetail> query = meiyingDetailBox
        .query(MeiYingDetail_.detailId.equals(detailId))
        .order(MeiYingDetail_.imgUrl, flags: Order.descending)
        .build();
    List<MeiYingDetail> momos = await query.findAsync();
    return momos;
  }

  getMomoLocal() async {
    var res = await rootBundle.loadString("assets/data/momo.json");
    // print(res);
    List<Momo> result = JSON().fromJson(res.toString(), List<Momo>);
    return result;
  }

  getMomoDetailLocal(int momoId, int page) async {
    var res = await rootBundle.loadString("assets/data/momo_33804.json");
    // print(res);
    List<MomoDetail> result = JSON().fromJson(res.toString(), List<MomoDetail>);
    return result;
  }

  getMeiYingLocal() async {
    var res = await rootBundle.loadString("assets/data/meiying.json");
    // print(res);
    List<MeiYing> result = JSON().fromJson(res.toString(), List<MeiYing>);
    return result;
  }

  getMeiYingDetailLocal(int meiyingId, int page) async {
    var res = await rootBundle.loadString("assets/data/meiying_45122.json");
    // print(res);
    List<MeiYingDetail> result =
        JSON().fromJson(res.toString(), List<MeiYingDetail>);
    return result;
  }
}
