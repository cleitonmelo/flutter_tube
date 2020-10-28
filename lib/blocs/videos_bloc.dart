import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/model/video.dart';
import 'package:flutter_tube/services/api.dart';

class VideoBloc implements BlocBase{
  Api api;

  List<Video> videos;

  final _videosController = StreamController();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController;

  VideoBloc(){
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async{
    videos = await api.search(search);
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

}