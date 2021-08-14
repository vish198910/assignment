class Movie {
  Movie({
    required this.title,
    required this.director,
    required this.posterPath,
    required this.id,
  });

  String title;
  String director;
  String posterPath;
  int id;

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
        title: map["title"],
        director: map["director"],
        posterPath: map["poster_path"],
        id: map["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "director": director,
        "poster_path": posterPath,
        "id": id,
      };
}
