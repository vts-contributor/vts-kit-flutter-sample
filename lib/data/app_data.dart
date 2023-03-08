import 'package:flutter/material.dart';

class Post {
  static final posts = [
    Post(Colors.amberAccent, 'Post 1', 1),
    Post(Colors.blue, 'Post 2', 2),
    Post(Colors.pinkAccent, 'Post 3', 3),
    Post(Colors.greenAccent, 'Post 4', 4),
    Post(Colors.blueGrey, 'Post 5', 5),
    Post(Colors.deepPurple, 'Post 6', 6),
    Post(Colors.lightGreen, 'Post 7', 7),
    Post(Colors.orangeAccent, 'Post 8', 8),
  ];
  final Color color;
  final String title;
  final int id;

  Post(this.color, this.title, this.id);
}

class User {
  static final users = [
    User(Colors.amberAccent, 1),
    User(Colors.blue, 2),
    User(Colors.pinkAccent, 3),
    User(Colors.greenAccent, 4),
    User(Colors.blueGrey, 5),
    User(Colors.deepPurple, 6),
    User(Colors.lightGreen, 7),
    User(Colors.orangeAccent, 8),
  ];
  final Color color;
  final int id;

  User(this.color, this.id);
}
