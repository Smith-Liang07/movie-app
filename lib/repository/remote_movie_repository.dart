import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:sobatbisnis_assesment/helper/api_base_helper.dart';
import 'package:sobatbisnis_assesment/model/movie_response.dart';

class RemoteMovieRepository {
  // final String _apiKey = "78b9f63937763a206bff26c070b94158";
  final String _apiKey = "169ecf2f2f0e3acd10c2ff1b2db0358d";

  ApiBaseHelper _apiBaseHelper = ApiBaseHelper(httpClient: http.Client());

  Future<List<Movie>> fetchPopularMovies() async {
    var response = await _apiBaseHelper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    var response = await _apiBaseHelper.get("movie/upcoming?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    var response = await _apiBaseHelper.get("movie/top_rated?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    var response =
        await _apiBaseHelper.get("movie/now_playing?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}
