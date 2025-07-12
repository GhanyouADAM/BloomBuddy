// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCareRecordCollection on Isar {
  IsarCollection<CareRecord> get careRecords => this.collection();
}

const CareRecordSchema = CollectionSchema(
  name: r'CareRecord',
  id: 3361972233876410296,
  properties: {
    r'careDate': PropertySchema(
      id: 0,
      name: r'careDate',
      type: IsarType.dateTime,
    ),
    r'caretype': PropertySchema(
      id: 1,
      name: r'caretype',
      type: IsarType.byte,
      enumMap: _CareRecordcaretypeEnumValueMap,
    ),
    r'note': PropertySchema(
      id: 2,
      name: r'note',
      type: IsarType.string,
    )
  },
  estimateSize: _careRecordEstimateSize,
  serialize: _careRecordSerialize,
  deserialize: _careRecordDeserialize,
  deserializeProp: _careRecordDeserializeProp,
  idName: r'careRecordId',
  indexes: {},
  links: {
    r'plant': LinkSchema(
      id: -6444710994742870768,
      name: r'plant',
      target: r'Plant',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _careRecordGetId,
  getLinks: _careRecordGetLinks,
  attach: _careRecordAttach,
  version: '3.1.0+1',
);

int _careRecordEstimateSize(
  CareRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _careRecordSerialize(
  CareRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.careDate);
  writer.writeByte(offsets[1], object.caretype.index);
  writer.writeString(offsets[2], object.note);
}

CareRecord _careRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CareRecord(
    careDate: reader.readDateTime(offsets[0]),
    caretype:
        _CareRecordcaretypeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
            Caretype.watering,
    note: reader.readStringOrNull(offsets[2]),
  );
  object.careRecordId = id;
  return object;
}

P _careRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (_CareRecordcaretypeValueEnumMap[reader.readByteOrNull(offset)] ??
          Caretype.watering) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CareRecordcaretypeEnumValueMap = {
  'watering': 0,
  'pruning': 1,
  'fertilizing': 2,
};
const _CareRecordcaretypeValueEnumMap = {
  0: Caretype.watering,
  1: Caretype.pruning,
  2: Caretype.fertilizing,
};

Id _careRecordGetId(CareRecord object) {
  return object.careRecordId;
}

List<IsarLinkBase<dynamic>> _careRecordGetLinks(CareRecord object) {
  return [object.plant];
}

void _careRecordAttach(IsarCollection<dynamic> col, Id id, CareRecord object) {
  object.careRecordId = id;
  object.plant.attach(col, col.isar.collection<Plant>(), r'plant', id);
}

extension CareRecordQueryWhereSort
    on QueryBuilder<CareRecord, CareRecord, QWhere> {
  QueryBuilder<CareRecord, CareRecord, QAfterWhere> anyCareRecordId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CareRecordQueryWhere
    on QueryBuilder<CareRecord, CareRecord, QWhereClause> {
  QueryBuilder<CareRecord, CareRecord, QAfterWhereClause> careRecordIdEqualTo(
      Id careRecordId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: careRecordId,
        upper: careRecordId,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterWhereClause>
      careRecordIdNotEqualTo(Id careRecordId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: careRecordId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: careRecordId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: careRecordId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: careRecordId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterWhereClause>
      careRecordIdGreaterThan(Id careRecordId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: careRecordId, includeLower: include),
      );
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterWhereClause> careRecordIdLessThan(
      Id careRecordId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: careRecordId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterWhereClause> careRecordIdBetween(
    Id lowerCareRecordId,
    Id upperCareRecordId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerCareRecordId,
        includeLower: includeLower,
        upper: upperCareRecordId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CareRecordQueryFilter
    on QueryBuilder<CareRecord, CareRecord, QFilterCondition> {
  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> careDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition>
      careDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'careDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> careDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'careDate',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> careDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'careDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition>
      careRecordIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careRecordId',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition>
      careRecordIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'careRecordId',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition>
      careRecordIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'careRecordId',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition>
      careRecordIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'careRecordId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> caretypeEqualTo(
      Caretype value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caretype',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition>
      caretypeGreaterThan(
    Caretype value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caretype',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> caretypeLessThan(
    Caretype value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caretype',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> caretypeBetween(
    Caretype lower,
    Caretype upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caretype',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }
}

extension CareRecordQueryObject
    on QueryBuilder<CareRecord, CareRecord, QFilterCondition> {}

extension CareRecordQueryLinks
    on QueryBuilder<CareRecord, CareRecord, QFilterCondition> {
  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> plant(
      FilterQuery<Plant> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'plant');
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterFilterCondition> plantIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'plant', 0, true, 0, true);
    });
  }
}

extension CareRecordQuerySortBy
    on QueryBuilder<CareRecord, CareRecord, QSortBy> {
  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> sortByCareDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careDate', Sort.asc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> sortByCareDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careDate', Sort.desc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> sortByCaretype() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caretype', Sort.asc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> sortByCaretypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caretype', Sort.desc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }
}

extension CareRecordQuerySortThenBy
    on QueryBuilder<CareRecord, CareRecord, QSortThenBy> {
  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByCareDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careDate', Sort.asc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByCareDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careDate', Sort.desc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByCareRecordId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careRecordId', Sort.asc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByCareRecordIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careRecordId', Sort.desc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByCaretype() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caretype', Sort.asc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByCaretypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caretype', Sort.desc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<CareRecord, CareRecord, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }
}

extension CareRecordQueryWhereDistinct
    on QueryBuilder<CareRecord, CareRecord, QDistinct> {
  QueryBuilder<CareRecord, CareRecord, QDistinct> distinctByCareDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'careDate');
    });
  }

  QueryBuilder<CareRecord, CareRecord, QDistinct> distinctByCaretype() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caretype');
    });
  }

  QueryBuilder<CareRecord, CareRecord, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }
}

extension CareRecordQueryProperty
    on QueryBuilder<CareRecord, CareRecord, QQueryProperty> {
  QueryBuilder<CareRecord, int, QQueryOperations> careRecordIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'careRecordId');
    });
  }

  QueryBuilder<CareRecord, DateTime, QQueryOperations> careDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'careDate');
    });
  }

  QueryBuilder<CareRecord, Caretype, QQueryOperations> caretypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caretype');
    });
  }

  QueryBuilder<CareRecord, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }
}
