import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/Library/Widgets/Inherited/provider.dart';
import 'package:movie/domain/api_client/api_client.dart';
import 'package:movie/domain/entity/movie_details_credits.dart';
import 'package:movie/theme/app_colors.dart';
import 'package:movie/ui/navigation/main_navigation.dart';
import 'package:movie/widgets/elements/radial_percent_widget.dart';
import 'package:movie/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: const [
          _TopPosterWidget(),
          _MovieNameWidget(),
          _RatingWidget(),
          _GenreInfoWidget(),
          _DescriptionWidget(),
          _TeamInfoWidget(),

        ],
      ),
    );
  }
}



class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model?.toggleFavorite(),
              icon: Icon(model?.isFavorite == true
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}



class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var year = model?.movieDetails?.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(children: [
          TextSpan(
              text: model?.movieDetails?.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              )
          ),
          TextSpan(
              text: year,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              )
          ),
        ]
        ),
      ),
    );
  }
}



class _RatingWidget extends StatelessWidget {
  const _RatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieDetails = NotifierProvider.watch<MovieDetailsModel>(context)?.movieDetails;
    var voteAverage = movieDetails?.voteAverage ?? 0;
    voteAverage = voteAverage * 10;
    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              primary: AppColors.mainWhite, // This is a custom color variable
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: RadialPercentWidget(
                      child:
                      Text(voteAverage.toStringAsFixed(0)),
                      percent: voteAverage / 100,
                      fillColor: AppColors.mainFillColor,
                      lineColor: AppColors.mainLineColor,
                      freeColor: AppColors.mainFreeColor,
                      lineWidth: 3
                  ),
                ),
                const SizedBox(width: 15,),
                const Text('User score'),
              ],
            )
        ),
        Container(
          height: 15,
          width: 1,
          color: Colors.grey,
        ),
        trailerKey != null
            ? TextButton.icon(
                onPressed: () => Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.movieTrailerWidget,
                    arguments: trailerKey
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play trailer'),
                style: TextButton.styleFrom(
                  primary: AppColors.mainWhite, // This is a custom color variable
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}



class _GenreInfoWidget extends StatelessWidget {
  const _GenreInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];
    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }
    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add(productionCountries.first.iso);
    }
    final runtime = model.movieDetails?.runtime ?? 0;
    final milliseconds = runtime * 60000;
    final runtimeDate = DateTime.fromMillisecondsSinceEpoch(milliseconds).toUtc();
    texts.add(DateFormat.Hm().format(runtimeDate));
    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresNames = <String>[];
      for (var genre in genres) {
        genresNames.add(genre.name);
      }
      texts.add(genresNames.join(', '));
    }
    return Container(
      width: double.infinity,
      child: ColoredBox(
        color: AppColors.mainDarkBrown,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(
            texts.join('  '),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.mainWhite,
              fontSize: 16,
          ),
          ),
        ),
      ),
    );
  }
}



class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    final overview = model?.movieDetails?.overview ?? '';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            child: Text(
              overview,
              style: const TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }
}



class _TeamInfoWidget extends StatelessWidget {
  const _TeamInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetailsModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
          crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: crewChunks.map((chunk) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _TeamInfoWidgetRow(employes: chunk),
            )).toList(),
      ),
    );
  }
}

class _TeamInfoWidgetRow extends StatelessWidget {
  final List<Employee> employes;
  const _TeamInfoWidgetRow({
    Key? key,
    required this.employes
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: employes.map((employee) =>
          _TeamInfoWidgetRowItem(employee: employee)).toList(),
    );
  }
}

class _TeamInfoWidgetRowItem extends StatelessWidget {
  final Employee employee;
  const _TeamInfoWidgetRowItem({
    Key? key,
    required this.employee
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _nameStyle = TextStyle(
        color: AppColors.mainWhite,
        fontSize: 16,
        fontWeight: FontWeight.w400
    );
    const _jobTitleStyle = TextStyle(
        color: AppColors.mainWhite,
        fontSize: 16,
        fontWeight: FontWeight.w200
    );
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.originalName, style: _nameStyle),
          Text(employee.job, style: _jobTitleStyle),
        ],
      ),
    );
  }
}





