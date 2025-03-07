class Post {
  final String title;
  final String excerpt;
  final String link;

  Post({required this.title, required this.excerpt, required this.link});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      link: json['link'],
    );
  }
}
