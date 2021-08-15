import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import '../models/movie_model.dart';

class DatabaseController {
  static late DatabaseController databaseController;
  static late Database _database;
  String movieTable = 'movie_table';
  String colId = 'id';
  String colTitle = 'title';
  String coldirector = 'director';
  String colPosterPath = 'poster_path';
  String colFilename = 'filename';
  DatabaseController._createInstance();

  factory DatabaseController() {
    databaseController = DatabaseController._createInstance();
    return databaseController;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'movies.db';
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $movieTable($colId TEXT PRIMARY KEY, $colTitle TEXT, '
        '$coldirector TEXT, $colPosterPath TEXT, $colFilename TEXT )');
  }

  //this function will return all the movies in the database.
  Future<List<Map<String, dynamic>>> getMovieMapList() async {
    Database db = await this.database;
    var result = await db.query(movieTable, orderBy: '$colId ASC');
    return result;
  }

  // this method will be used to insert movies in the database.
  Future<int> insertMovie(Movie movie) async {
    Database db = await this.database;
    var result = await db.insert(movieTable, movie.toMap());
    return result;
  }

  Future<int> updateMovie(Movie movie) async {
    var db = await this.database;
    Map<String, dynamic> row = {
      colTitle: movie.title,
      coldirector: movie.director,
      colPosterPath: movie.posterPath,
      colFilename: movie.filename
    };

    int result = await db
        .update(movieTable, row, where: '$colId = ?', whereArgs: [movie.id]);

    return result;
  }

  // this method will delete a movie
  Future<int> deleteMovie(String id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $movieTable WHERE $colId = $id');
    return result;
  }

  // Get number of Movie objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $movieTable');
    int result = int.parse(Sqflite.firstIntValue(x).toString());
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Movie List' [ List<Movie> ]
  Future<List<Movie>> getMovieList() async {
    var movieMapList = await getMovieMapList(); // Get 'Map List' from database
    int count =
        movieMapList.length; // Count the number of map entries in db table
    late List<Movie> movieList = [];
    // For loop to create a 'Movie List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      movieList.add(Movie.fromMap(movieMapList[i]));
    }
    return movieList;
  }

  // this function will check if a movies exists in the database.
  Future<bool> contain(String id) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from $movieTable WHERE $colId = $id');
    int result = int.parse(Sqflite.firstIntValue(x).toString());
    if (result == 0) return false;
    return true;
  }
}
