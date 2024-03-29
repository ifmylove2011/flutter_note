// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'common/model/reptile/mei_ying.dart';
import 'common/model/reptile/mei_ying_detail.dart';
import 'common/model/reptile/momo.dart';
import 'common/model/reptile/momo_detail.dart';
import 'common/model/reptile/xoxo.dart';
import 'common/model/reptile/xoxo_detail.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 554181165008796417),
      name: 'Momo',
      lastPropertyId: const IdUid(7, 3724144874425576011),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2192253455544057712),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 7547200317169031040),
            name: 'detailUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 9010743952602498448),
            name: 'postUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5993301589076212120),
            name: 'dataPid',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(6, 5641292022804945752),
            name: 'page',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3724144874425576011),
            name: 'descNum',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(
            name: 'details', srcEntity: 'MomoDetail', srcField: 'momo')
      ]),
  ModelEntity(
      id: const IdUid(2, 3534921696094948130),
      name: 'MomoDetail',
      lastPropertyId: const IdUid(7, 1306190001780927379),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6923841579067089926),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 6639789365229640403),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5429498135647839484),
            name: 'imgUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2312750288253394405),
            name: 'detailId',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2725807348861426141),
            name: 'page',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1523353315452663913),
            name: 'momoId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 1476286063050676806),
            relationTarget: 'Momo'),
        ModelProperty(
            id: const IdUid(7, 1306190001780927379),
            name: 'pageNum',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 7977515300787085056),
      name: 'MeiYing',
      lastPropertyId: const IdUid(7, 1604221836264442792),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3122138587440891481),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 589872150254232578),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8895499115611433989),
            name: 'detailUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7657379068432997358),
            name: 'postUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4901804460664993268),
            name: 'descNum',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 5118596251854340557),
            name: 'author',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1604221836264442792),
            name: 'page',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 5980662944741225307),
      name: 'MeiYingDetail',
      lastPropertyId: const IdUid(3, 7751235435111974215),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1328435859991254805),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6915015614489668330),
            name: 'imgUrl',
            type: 9,
            flags: 2080,
            indexId: const IdUid(2, 2271367505139409371)),
        ModelProperty(
            id: const IdUid(3, 7751235435111974215),
            name: 'detailId',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 3554892029225246103),
      name: 'Xoxo',
      lastPropertyId: const IdUid(5, 1392389883135313977),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 400369273150038480),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 1582971901912987169),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 456342408214457448),
            name: 'detailUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 732750677511412240),
            name: 'postUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1392389883135313977),
            name: 'page',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 550759498544268981),
      name: 'XoxoDetail',
      lastPropertyId: const IdUid(4, 6718351517402176841),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5273515685305308343),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2783011669813131525),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5478193475390506010),
            name: 'imgUrl',
            type: 9,
            flags: 2080,
            indexId: const IdUid(3, 6699475881340516779)),
        ModelProperty(
            id: const IdUid(4, 6718351517402176841),
            name: 'detailId',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(6, 550759498544268981),
      lastIndexId: const IdUid(3, 6699475881340516779),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [8035616526113113263],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Momo: EntityDefinition<Momo>(
        model: _entities[0],
        toOneRelations: (Momo object) => [],
        toManyRelations: (Momo object) => {
              RelInfo<MomoDetail>.toOneBacklink(6, object.dataPid!,
                  (MomoDetail srcObject) => srcObject.momo): object.details
            },
        getId: (Momo object) => object.dataPid,
        setId: (Momo object, int id) {
          object.dataPid = id;
        },
        objectToFB: (Momo object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final detailUrlOffset = object.detailUrl == null
              ? null
              : fbb.writeString(object.detailUrl!);
          final postUrlOffset =
              object.postUrl == null ? null : fbb.writeString(object.postUrl!);
          final descNumOffset =
              object.descNum == null ? null : fbb.writeString(object.descNum!);
          fbb.startTable(8);
          fbb.addOffset(0, titleOffset);
          fbb.addOffset(1, detailUrlOffset);
          fbb.addOffset(2, postUrlOffset);
          fbb.addInt64(3, object.dataPid ?? 0);
          fbb.addInt64(5, object.page);
          fbb.addOffset(6, descNumOffset);
          fbb.finish(fbb.endTable());
          return object.dataPid ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 4);
          final detailUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final postUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final dataPidParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final descNumParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 16);
          final pageParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 14);
          final object = Momo(
              title: titleParam,
              detailUrl: detailUrlParam,
              postUrl: postUrlParam,
              dataPid: dataPidParam,
              descNum: descNumParam,
              page: pageParam);
          InternalToManyAccess.setRelInfo<Momo>(
              object.details,
              store,
              RelInfo<MomoDetail>.toOneBacklink(6, object.dataPid!,
                  (MomoDetail srcObject) => srcObject.momo));
          return object;
        }),
    MomoDetail: EntityDefinition<MomoDetail>(
        model: _entities[1],
        toOneRelations: (MomoDetail object) => [object.momo],
        toManyRelations: (MomoDetail object) => {},
        getId: (MomoDetail object) => object.id,
        setId: (MomoDetail object, int id) {
          object.id = id;
        },
        objectToFB: (MomoDetail object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final imgUrlOffset =
              object.imgUrl == null ? null : fbb.writeString(object.imgUrl!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, imgUrlOffset);
          fbb.addInt64(3, object.detailId);
          fbb.addInt64(4, object.page);
          fbb.addInt64(5, object.momo.targetId);
          fbb.addInt64(6, object.pageNum);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final imgUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final detailIdParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final pageParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final pageNumParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final object = MomoDetail(
              id: idParam,
              title: titleParam,
              imgUrl: imgUrlParam,
              detailId: detailIdParam,
              page: pageParam,
              pageNum: pageNumParam);
          object.momo.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.momo.attach(store);
          return object;
        }),
    MeiYing: EntityDefinition<MeiYing>(
        model: _entities[2],
        toOneRelations: (MeiYing object) => [],
        toManyRelations: (MeiYing object) => {},
        getId: (MeiYing object) => object.id,
        setId: (MeiYing object, int id) {
          object.id = id;
        },
        objectToFB: (MeiYing object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final detailUrlOffset = object.detailUrl == null
              ? null
              : fbb.writeString(object.detailUrl!);
          final postUrlOffset =
              object.postUrl == null ? null : fbb.writeString(object.postUrl!);
          final descNumOffset =
              object.descNum == null ? null : fbb.writeString(object.descNum!);
          final authorOffset =
              object.author == null ? null : fbb.writeString(object.author!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, detailUrlOffset);
          fbb.addOffset(3, postUrlOffset);
          fbb.addOffset(4, descNumOffset);
          fbb.addOffset(5, authorOffset);
          fbb.addInt64(6, object.page);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final detailUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final postUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final descNumParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 12);
          final authorParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 14);
          final pageParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final object = MeiYing(
              id: idParam,
              title: titleParam,
              detailUrl: detailUrlParam,
              postUrl: postUrlParam,
              descNum: descNumParam,
              author: authorParam,
              page: pageParam);

          return object;
        }),
    MeiYingDetail: EntityDefinition<MeiYingDetail>(
        model: _entities[3],
        toOneRelations: (MeiYingDetail object) => [],
        toManyRelations: (MeiYingDetail object) => {},
        getId: (MeiYingDetail object) => object.id,
        setId: (MeiYingDetail object, int id) {
          object.id = id;
        },
        objectToFB: (MeiYingDetail object, fb.Builder fbb) {
          final imgUrlOffset =
              object.imgUrl == null ? null : fbb.writeString(object.imgUrl!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, imgUrlOffset);
          fbb.addInt64(2, object.detailId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final imgUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final detailIdParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final object = MeiYingDetail(
              imgUrl: imgUrlParam, detailId: detailIdParam)
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);

          return object;
        }),
    Xoxo: EntityDefinition<Xoxo>(
        model: _entities[4],
        toOneRelations: (Xoxo object) => [],
        toManyRelations: (Xoxo object) => {},
        getId: (Xoxo object) => object.id,
        setId: (Xoxo object, int id) {
          object.id = id;
        },
        objectToFB: (Xoxo object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final detailUrlOffset = object.detailUrl == null
              ? null
              : fbb.writeString(object.detailUrl!);
          final postUrlOffset =
              object.postUrl == null ? null : fbb.writeString(object.postUrl!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, detailUrlOffset);
          fbb.addOffset(3, postUrlOffset);
          fbb.addInt64(4, object.page);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final detailUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final postUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final pageParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final object = Xoxo(
              id: idParam,
              title: titleParam,
              detailUrl: detailUrlParam,
              postUrl: postUrlParam,
              page: pageParam);

          return object;
        }),
    XoxoDetail: EntityDefinition<XoxoDetail>(
        model: _entities[5],
        toOneRelations: (XoxoDetail object) => [],
        toManyRelations: (XoxoDetail object) => {},
        getId: (XoxoDetail object) => object.id,
        setId: (XoxoDetail object, int id) {
          object.id = id;
        },
        objectToFB: (XoxoDetail object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final imgUrlOffset =
              object.imgUrl == null ? null : fbb.writeString(object.imgUrl!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, imgUrlOffset);
          fbb.addInt64(3, object.detailId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final imgUrlParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final detailIdParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final object = XoxoDetail(
              title: titleParam, imgUrl: imgUrlParam, detailId: detailIdParam)
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Momo] entity fields to define ObjectBox queries.
class Momo_ {
  /// see [Momo.title]
  static final title = QueryStringProperty<Momo>(_entities[0].properties[0]);

  /// see [Momo.detailUrl]
  static final detailUrl =
      QueryStringProperty<Momo>(_entities[0].properties[1]);

  /// see [Momo.postUrl]
  static final postUrl = QueryStringProperty<Momo>(_entities[0].properties[2]);

  /// see [Momo.dataPid]
  static final dataPid = QueryIntegerProperty<Momo>(_entities[0].properties[3]);

  /// see [Momo.page]
  static final page = QueryIntegerProperty<Momo>(_entities[0].properties[4]);

  /// see [Momo.descNum]
  static final descNum = QueryStringProperty<Momo>(_entities[0].properties[5]);
}

/// [MomoDetail] entity fields to define ObjectBox queries.
class MomoDetail_ {
  /// see [MomoDetail.id]
  static final id =
      QueryIntegerProperty<MomoDetail>(_entities[1].properties[0]);

  /// see [MomoDetail.title]
  static final title =
      QueryStringProperty<MomoDetail>(_entities[1].properties[1]);

  /// see [MomoDetail.imgUrl]
  static final imgUrl =
      QueryStringProperty<MomoDetail>(_entities[1].properties[2]);

  /// see [MomoDetail.detailId]
  static final detailId =
      QueryIntegerProperty<MomoDetail>(_entities[1].properties[3]);

  /// see [MomoDetail.page]
  static final page =
      QueryIntegerProperty<MomoDetail>(_entities[1].properties[4]);

  /// see [MomoDetail.momo]
  static final momo =
      QueryRelationToOne<MomoDetail, Momo>(_entities[1].properties[5]);

  /// see [MomoDetail.pageNum]
  static final pageNum =
      QueryIntegerProperty<MomoDetail>(_entities[1].properties[6]);
}

/// [MeiYing] entity fields to define ObjectBox queries.
class MeiYing_ {
  /// see [MeiYing.id]
  static final id = QueryIntegerProperty<MeiYing>(_entities[2].properties[0]);

  /// see [MeiYing.title]
  static final title = QueryStringProperty<MeiYing>(_entities[2].properties[1]);

  /// see [MeiYing.detailUrl]
  static final detailUrl =
      QueryStringProperty<MeiYing>(_entities[2].properties[2]);

  /// see [MeiYing.postUrl]
  static final postUrl =
      QueryStringProperty<MeiYing>(_entities[2].properties[3]);

  /// see [MeiYing.descNum]
  static final descNum =
      QueryStringProperty<MeiYing>(_entities[2].properties[4]);

  /// see [MeiYing.author]
  static final author =
      QueryStringProperty<MeiYing>(_entities[2].properties[5]);

  /// see [MeiYing.page]
  static final page = QueryIntegerProperty<MeiYing>(_entities[2].properties[6]);
}

/// [MeiYingDetail] entity fields to define ObjectBox queries.
class MeiYingDetail_ {
  /// see [MeiYingDetail.id]
  static final id =
      QueryIntegerProperty<MeiYingDetail>(_entities[3].properties[0]);

  /// see [MeiYingDetail.imgUrl]
  static final imgUrl =
      QueryStringProperty<MeiYingDetail>(_entities[3].properties[1]);

  /// see [MeiYingDetail.detailId]
  static final detailId =
      QueryIntegerProperty<MeiYingDetail>(_entities[3].properties[2]);
}

/// [Xoxo] entity fields to define ObjectBox queries.
class Xoxo_ {
  /// see [Xoxo.id]
  static final id = QueryIntegerProperty<Xoxo>(_entities[4].properties[0]);

  /// see [Xoxo.title]
  static final title = QueryStringProperty<Xoxo>(_entities[4].properties[1]);

  /// see [Xoxo.detailUrl]
  static final detailUrl =
      QueryStringProperty<Xoxo>(_entities[4].properties[2]);

  /// see [Xoxo.postUrl]
  static final postUrl = QueryStringProperty<Xoxo>(_entities[4].properties[3]);

  /// see [Xoxo.page]
  static final page = QueryIntegerProperty<Xoxo>(_entities[4].properties[4]);
}

/// [XoxoDetail] entity fields to define ObjectBox queries.
class XoxoDetail_ {
  /// see [XoxoDetail.id]
  static final id =
      QueryIntegerProperty<XoxoDetail>(_entities[5].properties[0]);

  /// see [XoxoDetail.title]
  static final title =
      QueryStringProperty<XoxoDetail>(_entities[5].properties[1]);

  /// see [XoxoDetail.imgUrl]
  static final imgUrl =
      QueryStringProperty<XoxoDetail>(_entities[5].properties[2]);

  /// see [XoxoDetail.detailId]
  static final detailId =
      QueryIntegerProperty<XoxoDetail>(_entities[5].properties[3]);
}
