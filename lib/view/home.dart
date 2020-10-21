import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviedb_app/view/detail.dart';
import 'package:moviedb_app/movie_model/movie.dart';
import 'package:moviedb_app/movie_model/results.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Results> popularMovie;

  String baseUrl = 'https://api.themoviedb.org/3';
  String apiKey = '821eed6517e117c279f59ead035cd436';
  String posterUrl = 'https://image.tmdb.org/t/p/w500';
  Future<Movie> getData() async {
    //ini kyk state interface dan restrofit configuration
    var res = await http.get(Uri.encodeFull('$baseUrl/movie/popular?api_key=$apiKey'),
        headers:{'accept': 'applications/json'} );
    var movies = Movie();
    setState(() {
      // ini state sukses
      if(res.statusCode == 200) {
        movies = Movie.fromJsonMap(jsonDecode(res.body));
        popularMovie = movies.results;
      } else {
        throw Exception(res.statusCode);
      }
    });
    return movies; //sumber data
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //bikin 2 katalog, isinya poster
    padding: EdgeInsets.all(4.0),
      child: GridView.builder(
          itemCount: popularMovie == null ? 0 : popularMovie.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7
          ),
          itemBuilder: (BuildContext context, int position) {
            return GestureDetector(
              //context dlm context
              //gesture detector -> pas kita masukin item apapun, dia bakall clickable. tdk memiliki children kek container, cuma punya child
              //karna kita butuh onTap dan yg bisa munculin ya gesture detector
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageDetail(results : popularMovie[position]); //return ke halaman detail kita
                }));
              }, //ketika item di click mau kemana
              child: Container(
                child: Card(
                  child: Container(
                    child: Image.network(
                      this.posterUrl + popularMovie[position].poster_path,
                      fit: BoxFit.fill,),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
