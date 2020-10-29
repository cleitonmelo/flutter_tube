import 'dart:convert';

import 'package:flutter_tube/model/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyD-31WTCusrLrR2Nr5e5jHQ0W545VW9rvg";

class Api {
  final String baseUrl = "https://www.googleapis.com/youtube/v3";
  final String suggestBaseUrl = "http://suggestqueries.google.com/complete";

  String _nextToken;
  String _search;

  getUrl(String search) {
    String url =
        "$baseUrl/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10";
    if (_nextToken != null) {
      url += "&pageToken=$_nextToken";
    }
    return url;
  }

  get suggestion {
    return "$suggestBaseUrl/search?hl=en&ds=yt&client=youtube&json=t&cp=1";
  }

  Future<List> search(String search) async {
    _search = search;
    print(getUrl(search));
    http.Response response = await http.get(getUrl(search));
    return decoder(response);
  }

  Future<List> nextPage() async {
    http.Response response = await http.get(getUrl(_search));
    return decoder(response);
  }

  Future<List> suggestions(String search) async {
    http.Response response =
        await http.get("$suggestion&q=$search&format=5&alt=json");
    if (statusCodeSucess(response.statusCode)) {
      return json.decode(response.body)[1].map((value) {
        return value;
      }).toList();
    }
    throw Exception("Erro ao pesquisar sugestões");
  }

  List<Video> decoder(http.Response response) {
    if (statusCodeSucess(response.statusCode)) {
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];

      List<Video> videos = decoded["items"].map<Video>((data) {
        return Video.fromJson(data);
      }).toList();
      return videos;
    }
    throw Exception("Falha ao buscar conteudo");
  }

  statusCodeSucess(code) => code == 200;
}
