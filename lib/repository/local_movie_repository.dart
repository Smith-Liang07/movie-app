import 'package:sqflite/sqflite.dart';

import 'package:sobatbisnis_assesment/helper/db_helper.dart';
import 'package:sobatbisnis_assesment/model/movie_response.dart';

class LocalMovieRepository {
  var databaseFuture = DatabaseHelper.db.database;
  static const POKEMON_TABLE_NAME = 'pokemon';
}
