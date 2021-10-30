import 'package:sobatbisnis_assesment/model/movie_comment.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sobatbisnis_assesment/helper/db_helper.dart';

class LocalCommentRepository {
  var databaseFuture = DatabaseHelper.db.database;
  static const COMMENT_TABLE_NAME = 'movie_review';

  Future<List<MovieComment>> getAllComments() async {
    late final List<MovieComment> commentList;
    final Database database = await databaseFuture;
    final commentMap = await database.query(COMMENT_TABLE_NAME);
    commentList =
        commentMap.map((comment) => MovieComment.fromMap(comment)).toList();
    return commentList;
  }

  Future<void> updateLocalMovieComment(List<MovieComment> commentList) async {
    final Database database = await databaseFuture;
    Batch batch = database.batch();
    commentList.forEach((comment) async {
      batch.insert(
        COMMENT_TABLE_NAME,
        comment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
    batch.commit();
  }

  Future<MovieComment> insert(MovieComment comment) async {
    final Database database = await databaseFuture;
    comment.id = await database.insert(COMMENT_TABLE_NAME, comment.toMap());
    return comment;
  }

  Future<MovieComment?> getComment(int id) async {
    final Database database = await databaseFuture;
    List<Map<String, dynamic>> maps = await database.query(COMMENT_TABLE_NAME,
        columns: ["name", "review", "rate"], where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return MovieComment.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    final Database database = await databaseFuture;
    return await database
        .delete(COMMENT_TABLE_NAME, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(MovieComment comment) async {
    final Database database = await databaseFuture;
    return await database.update(COMMENT_TABLE_NAME, comment.toMap(),
        where: 'id = ?', whereArgs: [comment.id]);
  }
}
