// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'got_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GotCharacter _$GotCharacterFromJson(Map<String, dynamic> json) => GotCharacter(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  fullName: json['fullName'] as String?,
  title: json['title'] as String?,
  family: json['family'] as String?,
  image: json['image'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$GotCharacterToJson(GotCharacter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'title': instance.title,
      'family': instance.family,
      'image': instance.image,
      'imageUrl': instance.imageUrl,
    };
