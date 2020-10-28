import 'dart:convert';

import 'package:flutter_tube/model/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyBlGxkbQCg-yNXxKcLxl97WFyKEB2kCl6s";

class Api {
  final String baseUrl = "https://www.googleapis.com/youtube/v3";
  final String suggestBaseUrl = "http://suggestqueries.google.com/complete";

  get url {
    return "$baseUrl/search?part=snippet";
  }

  get suggestion{
    return "$suggestBaseUrl/search?hl=en&ds=yt&client=youtube&json=t&cp=1";
  }

  search(String search) async {
    http.Response response = await http.get(
        "$url&q=$search&type=video&key=$API_KEY&maxResults=10");
    return decoder(response);
  }

  Future<List> suggestions(String search) async{
    http.Response response = await http.get(
      "$suggestion&q=$search&format=5&alt=json"
    );
    if(statusCodeSucess(response.statusCode)){
      return json.decode(response.body)[1].map((value){
        return value;
      }).toList();
    }
    throw Exception("Erro ao pesquisar sugestões");
  }

  List<Video> decoder(http.Response response) {
    if(statusCodeSucess(response.statusCode)){
      List<Video> videos = json.decode(response.body)["items"].map<Video>((data) {
        return Video.fromJson(data);
      }).toList();
      return videos;
    }
    throw Exception("Falha ao buscar conteudo");
  }

  statusCodeSucess(code) => code == 200;

}
