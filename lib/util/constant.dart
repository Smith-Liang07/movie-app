import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DB {
  static String DATABASE_NAME = 'movie.db';

  static String CREATE_MOVIE_TABLE = '''
    create table movie (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      url TEXT
    )
''';

  static String CREATE_REVIEW_TABLE = '''
    create table movie_review (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      review TEXT,
      rate INTEGER,
    )
''';
}

const kThemoviedbImageURL = "https://image.tmdb.org/t/p/w300";

const kMainGreenColor = Color(0xFF37A45E);
const kMainOrangeColor = Color(0xFFE58901);
const kMainBlueColor = Color(0xFF2C78C5);
const kMainPinkColor = Color(0xFFE84CAF);

const kPrimaryColor = Color(0xFF101010);
const kLightGrey = Color(0xFF545454);
const kAppBarColor = Color(0xFF1C1C1C);
const kTextShadowColor = Color(0x4D000000);
const kBackgroundShadowColor = Color(0x4D161616);
const kDrawerLineColor = Color(0xFF707070);
const kInactiveButtonColor = Color(0xFF474747);
const kDrawerTextColor = Color(0xFFBEBEBE);
const kSubTitleCardBoxColor = Color(0xFF8E8E8E);
const kSearchAppBarColor = Color(0xFF161616);

final kBoxShadow = [
  BoxShadow(
    color: kPrimaryColor,
    spreadRadius: 5,
    blurRadius: 30.sp,
    offset: Offset(0, 3),
  ),
];

final kAppBarTitleStyle =
    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
final kBottomTitleStyle =
    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
final kMovieCardTitleStyle =
    TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600);
final kMovieCardDateStyle =
    TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300);
final kMovieCardDescStyle =
    TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300);

final kDetailMovieTitleStyle =
    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
final kDetailMovieDescStyle =
    TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300);
