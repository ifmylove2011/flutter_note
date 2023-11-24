import 'dart:convert';

import 'package:html/dom.dart';

import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/convert.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';
import 'package:flutter_note/objectbox.g.dart';
import 'package:web_scraper/web_scraper.dart';

import '../../main.dart';
import '../model/reptile/momo_detail.dart';

class ReptileService {
  static ReptileService? _instance;
  final momoBox = objectBox.store.box<Momo>();
  final momoDetailBox = objectBox.store.box<MomoDetail>();

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
      momos.sort((a, b) => b.dataPid!.compareTo(a.dataPid!));
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
      momoDetails.sort((a, b) => b.id!.compareTo(a.id!));
      momoDetailBox.putManyAsync(momoDetails);
    }
    return momoDetails;
  }

  Future<String?> requestMomoPost(int page) async {
    WebScraper webScraperMomo = WebScraper();
    String dest = 'https://www.momotk4.es/?page=$page';
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
      int pageNum = int.parse(webScraperMomo
          .select('div.ngg-navigation > a.page-numbers')!
          .attributes['data-pageid']!);
      for (var thumbnail in thumbnails) {
        Map<String, dynamic> detail = {};
        detail['id'] = int.parse(thumbnail.attributes['data-image-id']!);
        detail['title'] = thumbnail.attributes['data-title'];
        detail['img_url'] = thumbnail.attributes['href'];
        detail['detail_id'] = detailId;
        detail['page'] = page;
        detail['page_num'] = pageNum;
        detail['total_page'] = page;
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
}
