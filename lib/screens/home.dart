import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';
import 'package:flutter_tube/delegates/search.dart';
import 'package:flutter_tube/widgets/video_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final videosBloc = BlocProvider.of<VideoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25.0,
          child: Image.asset("images/youtube_logo-300x67.png"),
        ),
        elevation: 0.0,
        backgroundColor: Colors.black,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text("0",style: GoogleFonts.aBeeZee(fontSize: 15.0),),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: Search());
              if(result != null){
                videosBloc.inSearch.add(result);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: videosBloc.outVideos,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemBuilder: (context, index) {
                    if(index < snapshot.data.length){
                      return VideoTile(video: snapshot.data[index]);
                    }
                    videosBloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length + 1,
              );
            }
            return Container();
          }
      ),
      backgroundColor: Colors.black,
    );
  }
}

    
    
    