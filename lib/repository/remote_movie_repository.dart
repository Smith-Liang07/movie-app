import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:sobatbisnis_assesment/helper/api_base_helper.dart';
import 'package:sobatbisnis_assesment/model/movie_response.dart';
import 'package:sobatbisnis_assesment/repository/movie_repository.dart';

class RemoteMovieRepository extends MovieRepository {
  final String _apiKey = "169ecf2f2f0e3acd10c2ff1b2db0358d";

  ApiBaseHelper _apiBaseHelper = ApiBaseHelper(httpClient: http.Client());

  @override
  Future<List<Movie>> fetchPopularMovies() async {
    var response = await _apiBaseHelper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  @override
  Future<List<Movie>> fetchUpcomingMovies() async {
    var response = await _apiBaseHelper.get("movie/upcoming?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  @override
  Future<List<Movie>> fetchTopRatedMovies() async {
    var response = await _apiBaseHelper.get("movie/top_rated?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  @override
  Future<List<Movie>> fetchNowPlayingMovies() async {
    var response =
        await _apiBaseHelper.get("movie/now_playing?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}
