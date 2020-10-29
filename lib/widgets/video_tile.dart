import 'package:flutter/material.dart';
import 'package:flutter_tube/model/video.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile({@required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(video.thumb, fit: BoxFit.cover),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8,8, 8,0),
                      child: Text(
                        video.title,
                        style: GoogleFonts.aBeeZee(fontSize: 16.0, color: Colors.white),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                          video.channel,
                          style: GoogleFonts.aBeeZee(fontSize: 12.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.star_border, color: Colors.white, size: 30.0),
                onPressed: (){

                },
              )
            ],
          )
        ],
      ),
    );
  }
}
