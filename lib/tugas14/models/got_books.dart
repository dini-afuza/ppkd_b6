// To parse this JSON data, do
//
//     final gotBooks = gotBooksFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'got_books.g.dart';

List<GotBooks> gotBooksFromJson(String str) =>
    List<GotBooks>.from(json.decode(str).map((x) => GotBooks.fromJson(x)));

String gotBooksToJson(List<GotBooks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GotBooks {
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "isbn")
  String isbn;
  @JsonKey(name: "authors")
  List<Author> authors;
  @JsonKey(name: "numberOfPages")
  int numberOfPages;
  @JsonKey(name: "publisher")
  String publisher;
  @JsonKey(name: "country")
  Country country;
  @JsonKey(name: "mediaType")
  String mediaType;
  @JsonKey(name: "released")
  DateTime released;
  @JsonKey(name: "characters")
  List<String> characters;
  @JsonKey(name: "povCharacters")
  List<String> povCharacters;

  GotBooks({
    required this.url,
    required this.name,
    required this.isbn,
    required this.authors,
    required this.numberOfPages,
    required this.publisher,
    required this.country,
    required this.mediaType,
    required this.released,
    required this.characters,
    required this.povCharacters,
  });

  factory GotBooks.fromJson(Map<String, dynamic> json) =>
      _$GotBooksFromJson(json);

  Map<String, dynamic> toJson() => _$GotBooksToJson(this);
}

enum Author {
  @JsonValue("George R. R. Martin")
  GEORGE_R_R_MARTIN,
}

final authorValues = EnumValues({
  "George R. R. Martin": Author.GEORGE_R_R_MARTIN,
});

enum Country {
  @JsonValue("United States")
  UNITED_STATES,
  @JsonValue("United Status")
  UNITED_STATUS,
}

final countryValues = EnumValues({
  "United States": Country.UNITED_STATES,
  "United Status": Country.UNITED_STATUS,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
