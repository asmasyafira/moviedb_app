import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviedb_app/tv_model/results.dart';
import 'package:moviedb_app/tv_model/tv.dart';
import 'package:moviedb_app/view/detail_tv.dart';


class HomeTvScreen extends StatefulWidget {
  @override
  _HomeTvScreenState createState() => _HomeTvScreenState();
}

class _HomeTvScreenState extends State<HomeTvScreen> {
  List <Results> popularTv;

  String baseUrl = 'https://api.themoviedb.org/3';
  String apiKey = '821eed6517e117c279f59ead035cd436';
  String posterUrl = 'https://image.tmdb.org/t/p/w500';
  Future<Tv> getTvData() async {
    var res = await http.get(Uri.encodeFull('$baseUrl/tv/popular?api_key=$apiKey&language=en-US&page=1'),
        headers:{'accept': 'applications/json'} );
    var tv = Tv();
    setState(() {
      if(res.statusCode == 200) {
        tv = Tv.fromJsonMap(jsonDecode(res.body));
        popularTv = tv.results;
      } else {
        throw Exception(res.statusCode);
      }
    });
    return tv;
  }

  @override
  void initState() {
    super.initState();
    this.getTvData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: GridView.builder(
          itemCount: popularTv == null ? 0 : popularTv.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7
          ),
          itemBuilder: (BuildContext context, int position) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PageTvDetail(results : popularTv[position]);
                }));
              },
              child: Container(
                child: Card(
                  child: Container(
                    child: Image.network(
                      this.posterUrl + popularTv[position].poster_path,
                      fit: BoxFit.fill,),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
