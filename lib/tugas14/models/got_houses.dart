// To parse this JSON data, do
//
//     final gotHouses = gotHousesFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'got_houses.g.dart';

List<GotHouses> gotHousesFromJson(String str) =>
    List<GotHouses>.from(json.decode(str).map((x) => GotHouses.fromJson(x)));

String gotHousesToJson(List<GotHouses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class GotHouses {
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "region")
  String region;
  @JsonKey(name: "coatOfArms")
  String coatOfArms;
  @JsonKey(name: "words")
  String words;
  @JsonKey(name: "titles")
  List<String> titles;
  @JsonKey(name: "seats")
  List<String> seats;
  @JsonKey(name: "currentLord")
  String currentLord;
  @JsonKey(name: "heir")
  String heir;
  @JsonKey(name: "overlord")
  String overlord;

  @JsonKey(name: "founded")
  String? founded; // <--- Diubah menjadi String? (nullable) agar aman dari error null/kosong

  @JsonKey(name: "founder")
  String founder;
  @JsonKey(name: "diedOut")
  String diedOut;
  @JsonKey(name: "ancestralWeapons")
  List<dynamic> ancestralWeapons;
  @JsonKey(name: "cadetBranches")
  List<String> cadetBranches;
  @JsonKey(name: "swornMembers")
  List<String> swornMembers;

  GotHouses({
    required this.url,
    required this.name,
    required this.region,
    required this.coatOfArms,
    required this.words,
    required this.titles,
    required this.seats,
    required this.currentLord,
    required this.heir,
    required this.overlord,
    this.founded, // <--- Diubah menjadi opsional karena tipenya nullable
    required this.founder,
    required this.diedOut,
    required this.ancestralWeapons,
    required this.cadetBranches,
    required this.swornMembers,
  });

  factory GotHouses.fromJson(Map<String, dynamic> json) =>
      _$GotHousesFromJson(json);

  Map<String, dynamic> toJson() => _$GotHousesToJson(this);
}
