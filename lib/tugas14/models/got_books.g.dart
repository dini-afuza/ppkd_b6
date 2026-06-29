// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'got_books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GotBooks _$GotBooksFromJson(Map<String, dynamic> json) => GotBooks(
  url: json['url'] as String,
  name: json['name'] as String,
  isbn: json['isbn'] as String,
  authors: (json['authors'] as List<dynamic>)
      .map((e) => $enumDecode(_$AuthorEnumMap, e))
      .toList(),
  numberOfPages: (json['numberOfPages'] as num).toInt(),
  publisher: json['publisher'] as String,
  country: $enumDecode(_$CountryEnumMap, json['country']),
  mediaType: json['mediaType'] as String,
  released: DateTime.parse(json['released'] as String),
  characters: (json['characters'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  povCharacters: (json['povCharacters'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$GotBooksToJson(GotBooks instance) => <String, dynamic>{
  'url': instance.url,
  'name': instance.name,
  'isbn': instance.isbn,
  'authors': instance.authors.map((e) => _$AuthorEnumMap[e]!).toList(),
  'numberOfPages': instance.numberOfPages,
  'publisher': instance.publisher,
  'country': _$CountryEnumMap[instance.country]!,
  'mediaType': instance.mediaType,
  'released': instance.released.toIso8601String(),
  'characters': instance.characters,
  'povCharacters': instance.povCharacters,
};

const _$AuthorEnumMap = {Author.GEORGE_R_R_MARTIN: 'George R. R. Martin'};

const _$CountryEnumMap = {
  Country.UNITED_STATES: 'United States',
  Country.UNITED_STATUS: 'United Status',
};
