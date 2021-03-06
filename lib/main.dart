import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:sobatbisnis_assesment/bloc/comment/cubit/comment_cubit.dart';
import 'package:sobatbisnis_assesment/bloc/cubit/movie_cubit_cubit.dart';
import 'package:sobatbisnis_assesment/repository/local_comment_repository.dart';
import 'package:sobatbisnis_assesment/repository/local_movie_repository.dart';
import 'package:sobatbisnis_assesment/repository/remote_movie_repository.dart';
import 'package:sobatbisnis_assesment/screens/coming_soon.dart';
import 'package:sobatbisnis_assesment/screens/now_playing.dart';
import 'package:sobatbisnis_assesment/screens/popular_screen.dart';
import 'package:sobatbisnis_assesment/screens/top_rated.dart';
import 'package:sobatbisnis_assesment/util/constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(home: Splash());
            },
          );
        } else {
          return Sizer(builder: (context, orientation, deviceType) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => MovieCubitCubit(
                      remoteMovieRepository: RemoteMovieRepository(),
                      localMovieRepository: LocalMovieRepository()),
                ),
                BlocProvider(
                  create: (context) =>
                      CommentCubit(commentRepository: LocalCommentRepository()),
                ),
              ],
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'MOVIE',
                theme: ThemeData.dark().copyWith(
                  primaryColor: kPrimaryColor,
                  scaffoldBackgroundColor: kPrimaryColor,
                ),
                home: MyHomePage(),
              ),
            );
          });
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeTab = 0;
  List bottomBarItems = [
    {"icon": Icons.hot_tub, "title": "Popular", "screen": PopularScreen()},
    {"icon": Icons.lock_clock, "title": "Coming Soon", "screen": ComingSoon()},
    {"icon": Icons.thumb_up, "title": "Top Rated", "screen": TopRated()},
    {"icon": Icons.play_circle, "title": "Playing Now", "screen": NowPlaying()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomBarItems[activeTab]["screen"],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _buildBottomNavBar() {
    return Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(bottomBarItems.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = index;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    bottomBarItems[index]["icon"],
                    color: activeTab == index ? Colors.white : Colors.grey,
                  ),
                  Text(
                    bottomBarItems[index]["title"],
                    style: TextStyle(
                        color: activeTab == index ? Colors.white : Colors.grey),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text(
          "MOVIE",
          style:
              kAppBarTitleStyle.copyWith(color: Colors.white, fontSize: 24.sp),
        ),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
