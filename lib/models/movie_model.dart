class Movie {
  Movie({
    required this.title,
    required this.director,
    required this.posterPath,
    required this.id,
    required this.filename
  });

  String title;
  String director;
  String posterPath;
  String id;
  String filename;

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
        title: map["title"],
        director: map["director"],
        posterPath: map["poster_path"],
        id: map["id"],
        filename: map["filename"]
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "director": director,
        "poster_path": posterPath,
        "id": id,
        "filename":filename
      };
}
