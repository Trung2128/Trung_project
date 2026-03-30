class Book {
  final String id;
  final String title;
  final String author;
  final String image;
  final String category;
  final String content;
  String status; 
  bool isFav;

  static List<Book> allBooks = [];

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.image,
    required this.category,
    required this.content,
    this.status = '',
    this.isFav = false,
  });
}