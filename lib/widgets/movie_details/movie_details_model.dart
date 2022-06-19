import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/domain/api_client/api_client.dart';
import 'package:movie/domain/data_providers/session_data_provider.dart';
import 'package:movie/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier{
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;
  bool? get isFavorite => _isFavorite;

  MovieDetailsModel(this.movieId);

  String stringFromDate(DateTime? date) => date != null
      ? _dateFormat.format(date)
      : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails () async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null ) {
      _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
    }
    notifyListeners();
  }

  Future <void> toggleFavorite () async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (accountId == null || sessionId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();
    await _apiClient.markAsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: ApiClientMediaType.Movie,
        mediaId: movieId,
        isFavorite: _isFavorite,
    );
  }
}