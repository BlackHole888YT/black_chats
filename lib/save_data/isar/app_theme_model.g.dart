// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppThemeModelCollection on Isar {
  IsarCollection<AppThemeModel> get appThemeModels => this.collection();
}

const AppThemeModelSchema = CollectionSchema(
  name: r'AppThemeModel',
  id: 886005498126014374,
  properties: {
    r'bottomLeftBallShadowValue': PropertySchema(
      id: 0,
      name: r'bottomLeftBallShadowValue',
      type: IsarType.long,
    ),
    r'bottomLeftBallValue': PropertySchema(
      id: 1,
      name: r'bottomLeftBallValue',
      type: IsarType.long,
    ),
    r'mainColorValue': PropertySchema(
      id: 2,
      name: r'mainColorValue',
      type: IsarType.long,
    ),
    r'outlineFocusedValue': PropertySchema(
      id: 3,
      name: r'outlineFocusedValue',
      type: IsarType.long,
    ),
    r'outlineUnFocusedValue': PropertySchema(
      id: 4,
      name: r'outlineUnFocusedValue',
      type: IsarType.long,
    ),
    r'textColorValue': PropertySchema(
      id: 5,
      name: r'textColorValue',
      type: IsarType.long,
    ),
    r'topRightBallShadowValue': PropertySchema(
      id: 6,
      name: r'topRightBallShadowValue',
      type: IsarType.long,
    ),
    r'topRightBallValue': PropertySchema(
      id: 7,
      name: r'topRightBallValue',
      type: IsarType.long,
    )
  },
  estimateSize: _appThemeModelEstimateSize,
  serialize: _appThemeModelSerialize,
  deserialize: _appThemeModelDeserialize,
  deserializeProp: _appThemeModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appThemeModelGetId,
  getLinks: _appThemeModelGetLinks,
  attach: _appThemeModelAttach,
  version: '3.1.0+1',
);

int _appThemeModelEstimateSize(
  AppThemeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _appThemeModelSerialize(
  AppThemeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.bottomLeftBallShadowValue);
  writer.writeLong(offsets[1], object.bottomLeftBallValue);
  writer.writeLong(offsets[2], object.mainColorValue);
  writer.writeLong(offsets[3], object.outlineFocusedValue);
  writer.writeLong(offsets[4], object.outlineUnFocusedValue);
  writer.writeLong(offsets[5], object.textColorValue);
  writer.writeLong(offsets[6], object.topRightBallShadowValue);
  writer.writeLong(offsets[7], object.topRightBallValue);
}

AppThemeModel _appThemeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppThemeModel();
  object.bottomLeftBallShadowValue = reader.readLong(offsets[0]);
  object.bottomLeftBallValue = reader.readLong(offsets[1]);
  object.id = id;
  object.mainColorValue = reader.readLong(offsets[2]);
  object.outlineFocusedValue = reader.readLong(offsets[3]);
  object.outlineUnFocusedValue = reader.readLong(offsets[4]);
  object.textColorValue = reader.readLong(offsets[5]);
  object.topRightBallShadowValue = reader.readLong(offsets[6]);
  object.topRightBallValue = reader.readLong(offsets[7]);
  return object;
}

P _appThemeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appThemeModelGetId(AppThemeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appThemeModelGetLinks(AppThemeModel object) {
  return [];
}

void _appThemeModelAttach(
    IsarCollection<dynamic> col, Id id, AppThemeModel object) {
  object.id = id;
}

extension AppThemeModelQueryWhereSort
    on QueryBuilder<AppThemeModel, AppThemeModel, QWhere> {
  QueryBuilder<AppThemeModel, AppThemeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppThemeModelQueryWhere
    on QueryBuilder<AppThemeModel, AppThemeModel, QWhereClause> {
  QueryBuilder<AppThemeModel, AppThemeModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppThemeModelQueryFilter
    on QueryBuilder<AppThemeModel, AppThemeModel, QFilterCondition> {
  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallShadowValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bottomLeftBallShadowValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallShadowValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bottomLeftBallShadowValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallShadowValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bottomLeftBallShadowValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallShadowValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bottomLeftBallShadowValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bottomLeftBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bottomLeftBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bottomLeftBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      bottomLeftBallValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bottomLeftBallValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      mainColorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      mainColorValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      mainColorValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      mainColorValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainColorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineFocusedValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outlineFocusedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineFocusedValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outlineFocusedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineFocusedValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outlineFocusedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineFocusedValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outlineFocusedValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineUnFocusedValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'outlineUnFocusedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineUnFocusedValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'outlineUnFocusedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineUnFocusedValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'outlineUnFocusedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      outlineUnFocusedValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'outlineUnFocusedValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      textColorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      textColorValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      textColorValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      textColorValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textColorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallShadowValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topRightBallShadowValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallShadowValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topRightBallShadowValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallShadowValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topRightBallShadowValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallShadowValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topRightBallShadowValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topRightBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topRightBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topRightBallValue',
        value: value,
      ));
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterFilterCondition>
      topRightBallValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topRightBallValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppThemeModelQueryObject
    on QueryBuilder<AppThemeModel, AppThemeModel, QFilterCondition> {}

extension AppThemeModelQueryLinks
    on QueryBuilder<AppThemeModel, AppThemeModel, QFilterCondition> {}

extension AppThemeModelQuerySortBy
    on QueryBuilder<AppThemeModel, AppThemeModel, QSortBy> {
  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByBottomLeftBallShadowValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallShadowValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByBottomLeftBallShadowValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallShadowValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByBottomLeftBallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByBottomLeftBallValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByMainColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColorValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByMainColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColorValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByOutlineFocusedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineFocusedValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByOutlineFocusedValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineFocusedValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByOutlineUnFocusedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineUnFocusedValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByOutlineUnFocusedValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineUnFocusedValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textColorValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByTextColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textColorValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByTopRightBallShadowValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallShadowValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByTopRightBallShadowValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallShadowValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByTopRightBallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      sortByTopRightBallValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallValue', Sort.desc);
    });
  }
}

extension AppThemeModelQuerySortThenBy
    on QueryBuilder<AppThemeModel, AppThemeModel, QSortThenBy> {
  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByBottomLeftBallShadowValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallShadowValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByBottomLeftBallShadowValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallShadowValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByBottomLeftBallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByBottomLeftBallValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bottomLeftBallValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByMainColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColorValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByMainColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainColorValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByOutlineFocusedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineFocusedValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByOutlineFocusedValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineFocusedValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByOutlineUnFocusedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineUnFocusedValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByOutlineUnFocusedValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'outlineUnFocusedValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textColorValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByTextColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textColorValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByTopRightBallShadowValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallShadowValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByTopRightBallShadowValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallShadowValue', Sort.desc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByTopRightBallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallValue', Sort.asc);
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QAfterSortBy>
      thenByTopRightBallValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topRightBallValue', Sort.desc);
    });
  }
}

extension AppThemeModelQueryWhereDistinct
    on QueryBuilder<AppThemeModel, AppThemeModel, QDistinct> {
  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByBottomLeftBallShadowValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bottomLeftBallShadowValue');
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByBottomLeftBallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bottomLeftBallValue');
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByMainColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainColorValue');
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByOutlineFocusedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'outlineFocusedValue');
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByOutlineUnFocusedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'outlineUnFocusedValue');
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByTextColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textColorValue');
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByTopRightBallShadowValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topRightBallShadowValue');
    });
  }

  QueryBuilder<AppThemeModel, AppThemeModel, QDistinct>
      distinctByTopRightBallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topRightBallValue');
    });
  }
}

extension AppThemeModelQueryProperty
    on QueryBuilder<AppThemeModel, AppThemeModel, QQueryProperty> {
  QueryBuilder<AppThemeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations>
      bottomLeftBallShadowValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bottomLeftBallShadowValue');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations>
      bottomLeftBallValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bottomLeftBallValue');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations> mainColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainColorValue');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations>
      outlineFocusedValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outlineFocusedValue');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations>
      outlineUnFocusedValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'outlineUnFocusedValue');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations> textColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textColorValue');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations>
      topRightBallShadowValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topRightBallShadowValue');
    });
  }

  QueryBuilder<AppThemeModel, int, QQueryOperations>
      topRightBallValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topRightBallValue');
    });
  }
}
