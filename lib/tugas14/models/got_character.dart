import 'package:json_annotation/json_annotation.dart';

part 'got_character.g.dart';

@JsonSerializable()
class GotCharacter {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "family")
  final String? family;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "imageUrl")
  final String? imageUrl;

  GotCharacter({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.title,
    this.family,
    this.image,
    this.imageUrl,
  });

  factory GotCharacter.fromJson(Map<String, dynamic> json) =>
      _$GotCharacterFromJson(json);

  Map<String, dynamic> toJson() => _$GotCharacterToJson(this);
}
