class Track {
  String? id;
  String? title;
  String? album;
  String? artist;
  String? artworkFile;
  String? audioStreamFile;
  String? audioSourceFile;
  int? duration;

  Track({
    required this.album,
    required this.artist,
    required this.artworkFile,
    required this.audioStreamFile,
    required this.audioSourceFile,
    required this.duration,
    required this.id,
    required this.title,
  });

  Track.empty();
}
