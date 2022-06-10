import 'package:flutter/material.dart';
import 'package:movie/resources/resources.dart';
import 'package:movie/theme/app_colors.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description
  });
}

class MovieListWidget extends StatefulWidget {

  MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
      id: 1,
      imageName: AppImages.movie,
      title: 'Passion',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
    Movie(
      id: 2,
      imageName: AppImages.movie,
      title: 'Need for Speed',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
    Movie(
      id: 3,
      imageName: AppImages.movie,
      title: 'Goal',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
    Movie(
      id: 4,
      imageName: AppImages.movie,
      title: 'Matrix',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
    Movie(
      id: 5,
      imageName: AppImages.movie,
      title: 'Breaking Bad',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
    Movie(
      id: 6,
      imageName: AppImages.movie,
      title: 'Khan',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
    Movie(
      id: 7,
      imageName: AppImages.movie,
      title: 'Go go',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
    Movie(
      id: 8,
      imageName: AppImages.movie,
      title: 'Duna',
      description: 'The Reyes-Elizondos idyllic lives are shattered by a murder charge against Eric and León.',
      time: 'Januar 1, 2003',
    ),
  ];

  var _filteredMovies = <Movie> [];

  final _searchController = TextEditingController();

  void _searchMovies () {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie){
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();

    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed('/main_screen/movie_details');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: 70),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _filteredMovies.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              final movie = _filteredMovies[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainWhite,
                        border: Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        children: [
                          Image(image: AssetImage(movie.imageName)),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Text(
                                  movie.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  movie.time,
                                  style: TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  movie.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  )
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _onMovieTap(index),
                      ),
                    )
                  ],
                ),
              );
        }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: AppColors.mainWhite.withAlpha(235),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
