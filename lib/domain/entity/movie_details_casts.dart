import 'package:json_annotation/json_annotation.dart';

part 'movie_details_casts.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsCasts {
    List<Actor> cast;
    List<Employee> crew;

    MovieDetailsCasts({
      required this.cast,
      required this.crew,
      });

}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Actor {
    bool adult;
    int castId;
    String character;
    String creditId;
    int? gender;
    int id;
    String knownForDepartment;
    String name;
    int order;
    String originalName;
    double popularity;
    String? profilePath;

    Actor({
      required this.adult,
      required this.castId,
      required this.character,
      required this.creditId,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.order,
      required this.originalName,
      required this.popularity,
      this.profilePath});
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Employee {
    bool adult;
    String creditId;
    String department;
    int? gender;
    int id;
    String job;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;

    Employee({
      required this.adult,
      required this.creditId,
      required this.department,
      required this.gender,
      required this.id,
      required this.job,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      this.profilePath});
}