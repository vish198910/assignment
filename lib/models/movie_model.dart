class Movie {
  Movie({
    required this.title,
    required this.director,
    required this.posterPath,
    required this.id,
    required this.isFavorite,
  });

  String title;
  String director;
  String posterPath;
  int id;
  bool isFavorite;

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
        title: map["title"],
        director: map["director"],
        posterPath: map["poster_path"],
        id: map["id"],
        isFavorite: map["is_favorite"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "director": director,
        "poster_path": posterPath,
        "id": id,
        "is_favorite": isFavorite,
      };
}
