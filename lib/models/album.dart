class Album {
  final String contant;
  final String author;

  const Album({
    required this.contant,
    required this.author,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      contant: json['content'],
      author: json['author'],
    );
  }
}
