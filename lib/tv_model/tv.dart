import 'package:moviedb_app/tv_model/results.dart';

class Tv {
  int page;
  int total_results;
  int total_pages;
  List<Results> results;

  Tv({this.page, this.total_results, this.total_pages, this.results});

  Tv.fromJsonMap(Map<String, dynamic> map) {
    page = map["page"];
    total_results = map["total_results"];
    total_pages = map["total_pages"];
    // results = List<Results>.from(map["results"].map((it) => Results.fromJsonMap(it)));
    if (map['results'] != null) {
      results = List<Results>();
      map['results'].forEach((v) {
        results.add(Results.fromJsonMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = page;
    data['total_results'] = total_results;
    data['total_pages'] = total_pages;
    // data['results'] =
    //     results != null ? this.results.map((v) => v.toJson()).toList() : null;
		if (this.results != null) {
			data['results'] = this.results.map((v) => v.toJson()).toList();
		}
    return data;
  }
}
