import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_note/common/model/reptile/momo.dart';
import 'package:flutter_note/common/net/reptile_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:web_scraper/web_scraper.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  // WebScraper webScraperMomo = WebScraper();
  WebScraper webScraperMomo = WebScraper();

  group('xoxo test', () {
    test('xoxo test', () async {
      bool page = await webScraperMomo
          .loadFullURL('https://girl-boy.xofulitu2cb789.xyz/arttype/2000-1/');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
      List<Map<String, dynamic>> xoxos = [];
      List<Element> posts = webScraperMomo.selects('div.picture-list > a');
      for (var post in posts) {
        Map<String, dynamic> xoxo = {};
        String path = post.attributes['href']!;
        xoxo['id'] = int.parse(path.split('/')[4]);
        xoxo['title'] = post.querySelector('div.album-name')!.text;
        xoxo['detail_url'] = 'https://girl-boy.xofulitu2cb789.xyz$path';
        xoxo['post_url'] =
            'https://girl-boy.xofulitu2cb789.xyz${post.querySelector('img')!.attributes['data-src']}';
        xoxo['page'] = 1;
        xoxos.add(xoxo);
      }
      String jsonS = json.encode(xoxos);
      print(jsonS);
      // var names =
      //     webScraperMomo.getElement('article a', ['href', 'data-src', 'h2']);
      // expect(names, isNotEmpty);
      // print(names);
      expect(posts, isNotEmpty);
    });
  });

  group('xoxo detail test', () {
    test('xoxo detail test', () async {
      bool page = await webScraperMomo
          .loadFullURL('https://girl-boy.xofulitu2cb789.xyz/art/pic/id/2267/');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
      List<Map<String, dynamic>> details = [];
      List<Element> thumbnails = webScraperMomo.selects('div.picture-item');
      for (var thumbnail in thumbnails) {
        Map<String, dynamic> detail = {};
        detail['title'] = thumbnail.querySelector('div.title')!.text.trim();
        detail['img_url'] =
            thumbnail.querySelector('a img')!.attributes['data-src'];
        detail['detail_id'] = 2255;
        // detail['page_num'] = pageNum;
        // detail['page'] = 1;
        details.add(detail);
      }
      String jsonS = json.encode(details);
      print(jsonS);
      expect(thumbnails, isNotEmpty);
    });
  });

  group('lesmao test', () {
    test('lesmao test', () async {
      bool page = await webScraperMomo.loadFullURL('https://www.lesmao.co');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
      List<Map<String, dynamic>> lesmaos = [];
      List<Element> posts = webScraperMomo.selects('div.photo > a');
      for (var post in posts) {
        Map<String, dynamic> lesmao = {};
        String path = post.attributes['href']!;
        lesmao['id'] = int.parse(path.split('-')[1]);
        lesmao['title'] = post.querySelector('img')!.attributes['alt'];
        lesmao['detail_url'] = 'https://www.lesmao.co/$path';
        lesmao['post_url'] = post.querySelector('img')!.attributes['src'];
        lesmao['page'] = 1;
        lesmaos.add(lesmao);
      }
      String jsonS = json.encode(lesmaos);
      print(jsonS);
      // var names =
      //     webScraperMomo.getElement('article a', ['href', 'data-src', 'h2']);
      // expect(names, isNotEmpty);
      // print(names);
      expect(posts, isNotEmpty);
    });
  });

  group('lesmao detail test', () {
    test('lesmao detail test', () async {
      bool page = await webScraperMomo
          .loadFullURL('https://www.lesmao.co/thread-34400-1-1.html');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
      List<Map<String, dynamic>> details = [];
      List<Element> thumbnails = webScraperMomo.selects('ul.adw li img');
      // int pageNum = int.parse(webScraperMomo
      //     .select('div.ngg-navigation > a.page-numbers')!
      //     .attributes['data-pageid']!);
      for (var thumbnail in thumbnails) {
        Map<String, dynamic> detail = {};
        detail['title'] = thumbnail.attributes['alt'];
        detail['img_url'] = thumbnail.attributes['src'];
        detail['detail_id'] = 34400;
        // detail['page_num'] = pageNum;
        detail['page'] = 1;
        details.add(detail);
      }
      String jsonS = json.encode(details);
      print(jsonS);
      expect(thumbnails, isNotEmpty);
    });
  });

  group('meiying test', () {
    test('meiying test', () async {
      bool page = await webScraperMomo.loadFullURL(
          'https://myhl5.uno/%e6%9c%80%e6%96%b0%e5%8f%91%e5%b8%83');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
      List<Map<String, dynamic>> meiyings = [];
      List<Element> posts = webScraperMomo.selects('div.post.grid.grid-zz');
      for (var post in posts) {
        Map<String, dynamic> meiying = Map();

        // print(article.querySelector('h2')!.text);
        // print(article.querySelector('a')!.attributes['href']);
        // print(article.querySelector('a img')!.attributes['data-src']);
        // print(article.querySelector('footer a')!.attributes['data-pid']);
        // print(article.querySelector('a div')!.text);
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
      print(jsonS);
      // var names =
      //     webScraperMomo.getElement('article a', ['href', 'data-src', 'h2']);
      // expect(names, isNotEmpty);
      // print(names);
      expect(posts, isNotEmpty);
    });
  });

  group('meiying detail test', () {
    test('meiying detail test', () async {
      bool page =
          await webScraperMomo.loadFullURL('https://myhl5.uno/45122.html');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
      List<Map<String, dynamic>> details = [];
      List<Element> thumbnails =
          webScraperMomo.selects('div.gallery-item.gallery-fancy-item a');
      for (var thumbnail in thumbnails) {
        Map<String, dynamic> detail = {};
        detail['img_url'] = thumbnail.attributes['href'];
        detail['detail_id'] = 45122;
        details.add(detail);
      }
      String jsonS = json.encode(details);
      print(jsonS);
      expect(thumbnails, isNotEmpty);
    });
  });

  group('momo test', () {
    test('momo test', () async {
      bool page =
          await webScraperMomo.loadFullURL('https://www.momotk4.es/?page=1');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
      List<Map<String, dynamic>> momos = [];
      List<Element> articles = webScraperMomo.selects('article');
      for (var article in articles) {
        Map<String, dynamic> momo = Map();

        // print(article.querySelector('h2')!.text);
        // print(article.querySelector('a')!.attributes['href']);
        // print(article.querySelector('a img')!.attributes['data-src']);
        // print(article.querySelector('footer a')!.attributes['data-pid']);
        // print(article.querySelector('a div')!.text);
        momo['title'] = article.querySelector('h2')!.text;
        momo['detail_url'] = article.querySelector('a')!.attributes['href'];
        momo['post_url'] =
            article.querySelector('a img')!.attributes['data-src'];
        momo['data-pid'] = int.parse(
            article.querySelector('footer a')!.attributes['data-pid']!);
        momo['desc_num'] = article.querySelector('a div')!.text;
        momo['page'] = 1;
        momos.add(momo);
      }
      String jsonS = json.encode(momos);
      print(jsonS);
      // var names =
      //     webScraperMomo.getElement('article a', ['href', 'data-src', 'h2']);
      // expect(names, isNotEmpty);
      // print(names);
      expect(articles, isNotEmpty);
    });
  });

  group('momo detail test', () {
    test('momo detail test', () async {
      bool page =
          await webScraperMomo.loadFullURL('https://www.momotk4.es/33804.html');
      expect(page, true);
    });
    // test('Gets Page Content & Loads from String', () {
    //   final pageContent = webScraperMomo.getPageContent();
    //   expect(pageContent, isA<String>());
    //   print(pageContent);
    // });
    test('Get Element ', () {
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
        detail['detail_id'] = 33804;
        detail['page_num'] = pageNum;
        detail['page'] = 1;
        details.add(detail);
      }
      String jsonS = json.encode(details);
      print(jsonS);
      expect(thumbnails, isNotEmpty);
    });
  });

  final webScraper = WebScraper('https://webscraper.io');

  group('Complete Web Scraper Test', () {
    bool page;
    var productNames = <Map<String, dynamic>>[];
    test('Loads Webpage Route', () async {
      page = await webScraper.loadWebPage('/test-sites/e-commerce/allinone');
      expect(page, true);
    });
    test('Loads Full URL', () async {
      expect(
          await WebScraper().loadFullURL(
              'https://webscraper.io/test-sites/e-commerce/allinone'),
          true);
    });
    test('Gets Page Content & Loads from String', () {
      final pageContent = webScraper.getPageContent();
      expect(pageContent, isA<String>());
    });
    test('Elapsed Time', () {
      // time elapsed is integral value (in milliseconds)
      var timeElapsed = webScraper.timeElaspsed;
      print('Elapsed Time(in Milliseconds): ' + timeElapsed.toString());
      expect(timeElapsed, isNotNull);
    });

    test('Get Element Title', () {
      var names = webScraper
          .getElementTitle('div.thumbnail > div.caption > h4 > a.title');
      expect(names, isEmpty);
    });

    test('Get Element Attribute', () {
      var names = webScraper.getElementAttribute(
          'div.thumbnail > div.caption > h4 > a.title', 'title');
      expect(names, isEmpty);
    });

    test('Get Elements by selector', () async {
      productNames = webScraper.getElement(
        'div.thumbnail > div.caption > h4 > a.title',
        ['href', 'title'],
      );
      expect(productNames, isNotNull);
    });
    test('Fetching All Scripts', () {
      var scripts = webScraper.getAllScripts();
      print('List of all script tags: ');
      print(scripts);
      expect(scripts, isNotNull);
    });
    test('Fetching Script variables', () {
      var variables = webScraper.getScriptVariables(['j.async']);
      print('List of all variable occurences: ');
      print(variables);
      expect(variables, isNotNull);
    });
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
