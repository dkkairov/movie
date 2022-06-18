// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsVideos _$MovieDetailsVideosFromJson(Map<String, dynamic> json) =>
    MovieDetailsVideos(
      results: (json['results'] as List<dynamic>)
          .map((e) =>
              MovieDetailsVideosResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsVideosToJson(MovieDetailsVideos instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

MovieDetailsVideosResult _$MovieDetailsVideosResultFromJson(
        Map<String, dynamic> json) =>
    MovieDetailsVideosResult(
      id: json['id'] as String,
      iso31661: json['iso_3166_1'] as String,
      iso6391: json['iso_639_1'] as String,
      key: json['key'] as String,
      name: json['name'] as String,
      official: json['official'] as bool,
      publishedAt: json['published_at'] as String,
      site: json['site'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$MovieDetailsVideosResultToJson(
        MovieDetailsVideosResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iso_3166_1': instance.iso31661,
      'iso_639_1': instance.iso6391,
      'key': instance.key,
      'name': instance.name,
      'official': instance.official,
      'published_at': instance.publishedAt,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
    };
