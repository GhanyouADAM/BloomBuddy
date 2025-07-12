// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlantCollection on Isar {
  IsarCollection<Plant> get plants => this.collection();
}

const PlantSchema = CollectionSchema(
  name: r'Plant',
  id: 3202799289401311532,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isFavorite': PropertySchema(
      id: 1,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'plantDescription': PropertySchema(
      id: 2,
      name: r'plantDescription',
      type: IsarType.string,
    ),
    r'plantName': PropertySchema(
      id: 3,
      name: r'plantName',
      type: IsarType.string,
    ),
    r'plantSpecie': PropertySchema(
      id: 4,
      name: r'plantSpecie',
      type: IsarType.string,
    ),
    r'requirements': PropertySchema(
      id: 5,
      name: r'requirements',
      type: IsarType.object,
      target: r'CareRequirements',
    )
  },
  estimateSize: _plantEstimateSize,
  serialize: _plantSerialize,
  deserialize: _plantDeserialize,
  deserializeProp: _plantDeserializeProp,
  idName: r'plantId',
  indexes: {},
  links: {
    r'careHistory': LinkSchema(
      id: -4589575653341805091,
      name: r'careHistory',
      target: r'CareRecord',
      single: false,
      linkName: r'plant',
    )
  },
  embeddedSchemas: {r'CareRequirements': CareRequirementsSchema},
  getId: _plantGetId,
  getLinks: _plantGetLinks,
  attach: _plantAttach,
  version: '3.1.0+1',
);

int _plantEstimateSize(
  Plant object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.plantDescription;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.plantName.length * 3;
  bytesCount += 3 + object.plantSpecie.length * 3;
  bytesCount += 3 +
      CareRequirementsSchema.estimateSize(
          object.requirements, allOffsets[CareRequirements]!, allOffsets);
  return bytesCount;
}

void _plantSerialize(
  Plant object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeBool(offsets[1], object.isFavorite);
  writer.writeString(offsets[2], object.plantDescription);
  writer.writeString(offsets[3], object.plantName);
  writer.writeString(offsets[4], object.plantSpecie);
  writer.writeObject<CareRequirements>(
    offsets[5],
    allOffsets,
    CareRequirementsSchema.serialize,
    object.requirements,
  );
}

Plant _plantDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Plant(
    plantDescription: reader.readStringOrNull(offsets[2]),
    plantName: reader.readString(offsets[3]),
    plantSpecie: reader.readString(offsets[4]),
    requirements: reader.readObjectOrNull<CareRequirements>(
          offsets[5],
          CareRequirementsSchema.deserialize,
          allOffsets,
        ) ??
        CareRequirements(),
  );
  object.createdAt = reader.readDateTime(offsets[0]);
  object.isFavorite = reader.readBool(offsets[1]);
  object.plantId = id;
  return object;
}

P _plantDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<CareRequirements>(
            offset,
            CareRequirementsSchema.deserialize,
            allOffsets,
          ) ??
          CareRequirements()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _plantGetId(Plant object) {
  return object.plantId;
}

List<IsarLinkBase<dynamic>> _plantGetLinks(Plant object) {
  return [object.careHistory];
}

void _plantAttach(IsarCollection<dynamic> col, Id id, Plant object) {
  object.plantId = id;
  object.careHistory
      .attach(col, col.isar.collection<CareRecord>(), r'careHistory', id);
}

extension PlantQueryWhereSort on QueryBuilder<Plant, Plant, QWhere> {
  QueryBuilder<Plant, Plant, QAfterWhere> anyPlantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlantQueryWhere on QueryBuilder<Plant, Plant, QWhereClause> {
  QueryBuilder<Plant, Plant, QAfterWhereClause> plantIdEqualTo(Id plantId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: plantId,
        upper: plantId,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> plantIdNotEqualTo(Id plantId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: plantId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: plantId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: plantId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: plantId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> plantIdGreaterThan(Id plantId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: plantId, includeLower: include),
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> plantIdLessThan(Id plantId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: plantId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> plantIdBetween(
    Id lowerPlantId,
    Id upperPlantId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerPlantId,
        includeLower: includeLower,
        upper: upperPlantId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlantQueryFilter on QueryBuilder<Plant, Plant, QFilterCondition> {
  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> isFavoriteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'plantDescription',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      plantDescriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'plantDescription',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plantDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plantDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plantDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plantDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plantDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plantDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plantDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      plantDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plantDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantId',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plantId',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plantId',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plantId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plantName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plantName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantName',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plantName',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantSpecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plantSpecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plantSpecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plantSpecie',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plantSpecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plantSpecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plantSpecie',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plantSpecie',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantSpecie',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> plantSpecieIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plantSpecie',
        value: '',
      ));
    });
  }
}

extension PlantQueryObject on QueryBuilder<Plant, Plant, QFilterCondition> {
  QueryBuilder<Plant, Plant, QAfterFilterCondition> requirements(
      FilterQuery<CareRequirements> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'requirements');
    });
  }
}

extension PlantQueryLinks on QueryBuilder<Plant, Plant, QFilterCondition> {
  QueryBuilder<Plant, Plant, QAfterFilterCondition> careHistory(
      FilterQuery<CareRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'careHistory');
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> careHistoryLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'careHistory', length, true, length, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> careHistoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'careHistory', 0, true, 0, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> careHistoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'careHistory', 0, false, 999999, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> careHistoryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'careHistory', 0, true, length, include);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      careHistoryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'careHistory', length, include, 999999, true);
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> careHistoryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'careHistory', lower, includeLower, upper, includeUpper);
    });
  }
}

extension PlantQuerySortBy on QueryBuilder<Plant, Plant, QSortBy> {
  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPlantDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantDescription', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPlantDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantDescription', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPlantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantName', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPlantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantName', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPlantSpecie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantSpecie', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPlantSpecieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantSpecie', Sort.desc);
    });
  }
}

extension PlantQuerySortThenBy on QueryBuilder<Plant, Plant, QSortThenBy> {
  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantDescription', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantDescription', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantName', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantName', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantSpecie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantSpecie', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPlantSpecieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantSpecie', Sort.desc);
    });
  }
}

extension PlantQueryWhereDistinct on QueryBuilder<Plant, Plant, QDistinct> {
  QueryBuilder<Plant, Plant, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByPlantDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plantDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByPlantName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plantName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByPlantSpecie(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plantSpecie', caseSensitive: caseSensitive);
    });
  }
}

extension PlantQueryProperty on QueryBuilder<Plant, Plant, QQueryProperty> {
  QueryBuilder<Plant, int, QQueryOperations> plantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plantId');
    });
  }

  QueryBuilder<Plant, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Plant, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> plantDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plantDescription');
    });
  }

  QueryBuilder<Plant, String, QQueryOperations> plantNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plantName');
    });
  }

  QueryBuilder<Plant, String, QQueryOperations> plantSpecieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plantSpecie');
    });
  }

  QueryBuilder<Plant, CareRequirements, QQueryOperations>
      requirementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requirements');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CareRequirementsSchema = Schema(
  name: r'CareRequirements',
  id: -5497885591947715905,
  properties: {
    r'fertilizingFrequencyWeeks': PropertySchema(
      id: 0,
      name: r'fertilizingFrequencyWeeks',
      type: IsarType.long,
    ),
    r'isFertilizing': PropertySchema(
      id: 1,
      name: r'isFertilizing',
      type: IsarType.bool,
    ),
    r'isPruning': PropertySchema(
      id: 2,
      name: r'isPruning',
      type: IsarType.bool,
    ),
    r'isWatering': PropertySchema(
      id: 3,
      name: r'isWatering',
      type: IsarType.bool,
    ),
    r'pruningFrequencyMonth': PropertySchema(
      id: 4,
      name: r'pruningFrequencyMonth',
      type: IsarType.long,
    ),
    r'wateringFrequencyDays': PropertySchema(
      id: 5,
      name: r'wateringFrequencyDays',
      type: IsarType.long,
    )
  },
  estimateSize: _careRequirementsEstimateSize,
  serialize: _careRequirementsSerialize,
  deserialize: _careRequirementsDeserialize,
  deserializeProp: _careRequirementsDeserializeProp,
);

int _careRequirementsEstimateSize(
  CareRequirements object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _careRequirementsSerialize(
  CareRequirements object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.fertilizingFrequencyWeeks);
  writer.writeBool(offsets[1], object.isFertilizing);
  writer.writeBool(offsets[2], object.isPruning);
  writer.writeBool(offsets[3], object.isWatering);
  writer.writeLong(offsets[4], object.pruningFrequencyMonth);
  writer.writeLong(offsets[5], object.wateringFrequencyDays);
}

CareRequirements _careRequirementsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CareRequirements(
    fertilizingFrequencyWeeks: reader.readLongOrNull(offsets[0]),
    pruningFrequencyMonth: reader.readLongOrNull(offsets[4]),
    wateringFrequencyDays: reader.readLongOrNull(offsets[5]),
  );
  return object;
}

P _careRequirementsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CareRequirementsQueryFilter
    on QueryBuilder<CareRequirements, CareRequirements, QFilterCondition> {
  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      fertilizingFrequencyWeeksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fertilizingFrequencyWeeks',
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      fertilizingFrequencyWeeksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fertilizingFrequencyWeeks',
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      fertilizingFrequencyWeeksEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fertilizingFrequencyWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      fertilizingFrequencyWeeksGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fertilizingFrequencyWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      fertilizingFrequencyWeeksLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fertilizingFrequencyWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      fertilizingFrequencyWeeksBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fertilizingFrequencyWeeks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      isFertilizingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFertilizing',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      isPruningEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPruning',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      isWateringEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isWatering',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      pruningFrequencyMonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pruningFrequencyMonth',
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      pruningFrequencyMonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pruningFrequencyMonth',
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      pruningFrequencyMonthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pruningFrequencyMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      pruningFrequencyMonthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pruningFrequencyMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      pruningFrequencyMonthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pruningFrequencyMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      pruningFrequencyMonthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pruningFrequencyMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      wateringFrequencyDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wateringFrequencyDays',
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      wateringFrequencyDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wateringFrequencyDays',
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      wateringFrequencyDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wateringFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      wateringFrequencyDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wateringFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      wateringFrequencyDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wateringFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CareRequirements, CareRequirements, QAfterFilterCondition>
      wateringFrequencyDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wateringFrequencyDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CareRequirementsQueryObject
    on QueryBuilder<CareRequirements, CareRequirements, QFilterCondition> {}
