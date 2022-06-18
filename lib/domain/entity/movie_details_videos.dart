import 'package:json_annotation/json_annotation.dart';

part 'movie_details_videos.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideos {
    List<MovieDetailsVideosResult> results;

    MovieDetailsVideos({
      required this.results
    });

    factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) =>
        _$MovieDetailsVideosFromJson(json);

    Map<String, dynamic> toJson() => _$MovieDetailsVideosToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideosResult {
    String id;
    @JsonKey(name: 'iso_3166_1')
    String iso31661;
    @JsonKey(name: 'iso_639_1')
    String iso6391;
    String key;
    String name;
    bool official;
    String publishedAt;
    String site;
    int size;
    String type;

    MovieDetailsVideosResult({
      required this.id,
      required this.iso31661,
      required this.iso6391,
      required this.key,
      required this.name,
      required this.official,
      required this.publishedAt,
      required this.site,
      required this.size,
      required this.type
    });

    factory MovieDetailsVideosResult.fromJson(Map<String, dynamic> json) =>
        _$MovieDetailsVideosResultFromJson(json);

    Map<String, dynamic> toJson() => _$MovieDetailsVideosResultToJson(this);

}