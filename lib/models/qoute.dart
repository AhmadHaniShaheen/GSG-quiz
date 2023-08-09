class Album {
  final String contant;
  final String author;
  final List tag;

  const Album({
    required this.contant,
    required this.author,
    required this.tag,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      contant: json['content'],
      author: json['author'],
      tag: json['tags'],
    );
  }
}
