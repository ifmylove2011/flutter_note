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
  WebScraper webScraperMomo = WebScraper();

  group('momo test', () {
    test('momo test', () async {
      bool page = await webScraperMomo.loadFullURL('https://www.momotk4.es/');
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
        momo['data-pid'] =
            article.querySelector('footer a')!.attributes['data-pid'];
        momo['desc_num'] = article.querySelector('a div')!.text;
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
