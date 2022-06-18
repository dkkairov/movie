import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/Library/Widgets/Inherited/provider.dart';
import 'package:movie/domain/api_client/api_client.dart';
import 'package:movie/resources/resources.dart';
import 'package:movie/theme/app_colors.dart';
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
                SizedBox(width: 15,),
                Text('User score'),
              ],
            )
        ),
        Container(
          height: 15,
          width: 1,
          color: Colors.grey,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.play_arrow),
          label: Text('Play trailer'),
          style: TextButton.styleFrom(
            primary: AppColors.mainWhite, // This is a custom color variable
          ),
        ),
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
      texts.add('${productionCountries.first.iso}');
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
    final nameStyle = TextStyle(
      color: AppColors.mainWhite,
      fontSize: 16,
      fontWeight: FontWeight.w400
    );

    final jobTitleStyle = TextStyle(
      color: AppColors.mainWhite,
      fontSize: 16,
      fontWeight: FontWeight.w400
    );


    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mel Gibson', style: nameStyle,),
                    Text('Director', style: jobTitleStyle)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Benedict Flitzgerald', style: nameStyle),
                    Text('Screenplay', style: jobTitleStyle)
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Hohns', style: nameStyle),
                    Text('Screenplay', style: jobTitleStyle)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Liza John', style: nameStyle),
                    Text('Screenplay', style: jobTitleStyle)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


