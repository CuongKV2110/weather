import 'package:json_annotation/json_annotation.dart';

part 'astro.g.dart';
@JsonSerializable()
class Astro {
  String sunrise;
  String sunset;
  String moonrise;
  String moonset;
  @JsonKey(name: "moon_phase")
  String moonPhase;
  @JsonKey(name: "moon_illumination")
  String moonIllumination;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });


  factory Astro.fromJson(Map<String, dynamic> json) => _$AstroFromJson(json);

  Map<String, dynamic> toJson() => _$AstroToJson(this);
}