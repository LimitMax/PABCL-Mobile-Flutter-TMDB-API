import 'package:flutter/material.dart';
import 'package:huraa/utils/text.dart';
import 'package:huraa/widgets/toprated.dart';
import 'package:huraa/widgets/trending.dart';
import 'package:huraa/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '90574175d9ab0c00ee4eee6335b69fe1';
  final readaccestoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MDU3NDE3NWQ5YWIwYzAwZWU0ZWVlNjMzNWI2OWZlMSIsInN1YiI6IjYyMTgzYTdiNWJlMDBlMDAxYjI4ZjJkZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WmYh5eJL-KGRUoutENgJwyULOzgYw7VBBKTAkyyAQ8A';

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccestoken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(tv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const modified_text(text: 'Movies Video App 🎥 ', color: Colors.grey, size: 20,),
      ),
      body: ListView(
        children: [
          TV(tv: tv),
          TopRated(toprated: topratedmovies),
          TrendingMovies(trending:trendingmovies)
        ],
      ),
    );
  }
}
