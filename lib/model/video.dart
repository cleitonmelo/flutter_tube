class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.title, this.thumb, this.channel});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"]["videoId"],
      title: json["snippet"]["title"],
      thumb: json["snippet"]["thumbnails"]["high"]["url"],
      channel: json["snippet"]["channelTitle"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "thumb": thumb,
      "channel": channel,
    };
  }

  String toString() {
    return toMap().toString();
  }
}
