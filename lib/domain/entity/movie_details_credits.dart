import 'package:json_annotation/json_annotation.dart';

part 'movie_details_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsCredits {
    List<Actor> cast;
    List<Employee> crew;

    MovieDetailsCredits({
      required this.cast,
      required this.crew,
      });

    factory MovieDetailsCredits.fromJson(Map<String, dynamic> json) =>
        _$MovieDetailsCreditsFromJson(json);

    Map<String, dynamic> toJson() => _$MovieDetailsCreditsToJson(this);

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

    factory Actor.fromJson(Map<String, dynamic> json) =>
        _$ActorFromJson(json);

    Map<String, dynamic> toJson() => _$ActorToJson(this);
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

    factory Employee.fromJson(Map<String, dynamic> json) =>
        _$EmployeeFromJson(json);

    Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}