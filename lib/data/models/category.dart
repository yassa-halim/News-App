class Category {
  String id;
  String name;
  String image;

  Category({required this.id, required this.name, required this.image});
}


List<Category> categories = [
  Category(id: 'general', name: 'General', image: 'general.png'),
  Category(id: 'business', name: 'Business', image: 'busniess.png'),
  Category(id: 'sport', name: 'Sport', image: 'sport.png'),
  Category(id: 'technology', name: 'Technology', image: 'technology.png'),
  Category(id: 'entertainment', name: 'Entertainment', image: 'entertainment.png'),
  Category(id: 'health', name: 'Health', image: 'helth.png'),
  Category(id: 'science', name: 'Science', image: 'science.png'),
];